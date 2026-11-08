
from pathlib import Path
from decimal import Decimal, ROUND_HALF_UP

import pandas as pd
from sqlalchemy import text

from db_connection import get_dw_engine


# ------------------------------------
# PROJECT PATHS
# ------------------------------------

BASE_DIR = Path(__file__).resolve().parent.parent

CSV_PATH = (
    BASE_DIR
    / "data_sources"
    / "inventory_movements.csv"
)


def load_fact_inventory():

    print("\n====================================")
    print("SuperMart Fact Inventory ETL Started")
    print("====================================")

    # ------------------------------------
    # 1. EXTRACT CSV DATA
    # ------------------------------------

    if not CSV_PATH.exists():
        raise FileNotFoundError(
            f"Inventory CSV not found: {CSV_PATH}"
        )

    df = pd.read_csv(CSV_PATH)

    print("CSV records extracted:", len(df))

    required_columns = [
        "movement_id",
        "branch_id",
        "product_id",
        "movement_date",
        "movement_type",
        "quantity_change",
        "reference_no"
    ]

    missing = [
        column
        for column in required_columns
        if column not in df.columns
    ]

    if missing:
        raise ValueError(
            f"Missing CSV columns: {missing}"
        )

    if df.empty:
        raise ValueError("Inventory CSV is empty")

    if df[required_columns[:-1]].isna().any().any():
        raise ValueError(
            "Required inventory fields contain null values"
        )

    if df["movement_id"].isna().any():
        raise ValueError(
            "movement_id contains null values"
        )

    if df["movement_id"].duplicated().any():
        raise ValueError(
            "Duplicate movement_id found"
        )

    # ------------------------------------
    # 2. TRANSFORM DATA TYPES
    # ------------------------------------

    for column in [
        "branch_id",
        "product_id",
        "quantity_change"
    ]:

        df[column] = pd.to_numeric(
            df[column],
            errors="raise"
        )

        if df[column].isna().any():
            raise ValueError(
                f"Null values in {column}"
            )

        if (df[column] % 1 != 0).any():
            raise ValueError(
                f"Non-integer values in {column}"
            )

        df[column] = df[column].astype(int)

    if (df["branch_id"] <= 0).any():
        raise ValueError("Invalid branch ID")

    if (df["product_id"] <= 0).any():
        raise ValueError("Invalid product ID")

    df["movement_date"] = pd.to_datetime(
        df["movement_date"],
        errors="raise"
    ).dt.normalize()

    df["movement_type"] = (
        df["movement_type"]
        .astype(str)
        .str.strip()
        .str.title()
    )

    valid_types = {
        "Opening",
        "Purchase",
        "Sale",
        "Return",
        "Adjustment"
    }

    invalid_types = (
        set(df["movement_type"]) - valid_types
    )

    if invalid_types:
        raise ValueError(
            f"Unknown movement types: {invalid_types}"
        )

    # ------------------------------------
    # 3. VALIDATE STOCK MOVEMENTS
    # ------------------------------------

    positive_types = [
        "Opening",
        "Purchase",
        "Return"
    ]

    if (
        df.loc[
            df["movement_type"].isin(positive_types),
            "quantity_change"
        ] < 0
    ).any():
        raise ValueError(
            "Opening/Purchase/Return must be positive"
        )

    if (
        df.loc[
            df["movement_type"] == "Sale",
            "quantity_change"
        ] > 0
    ).any():
        raise ValueError(
            "Sale movements must be negative"
        )

    df["stock_in"] = (
        df["quantity_change"].clip(lower=0)
    )

    df["stock_out"] = (
        -df["quantity_change"].clip(upper=0)
    )

    # ------------------------------------
    # 4. GROUP DAILY INVENTORY MOVEMENTS
    # ------------------------------------

    daily = (
        df.groupby(
            [
                "movement_date",
                "branch_id",
                "product_id"
            ],
            as_index=False
        )[["stock_in", "stock_out"]]
        .sum()
    )

    daily = daily.sort_values(
        [
            "branch_id",
            "product_id",
            "movement_date"
        ]
    ).reset_index(drop=True)

    daily["closing_stock"] = (
        daily.groupby(
            ["branch_id", "product_id"]
        )["stock_in"].cumsum()
        -
        daily.groupby(
            ["branch_id", "product_id"]
        )["stock_out"].cumsum()
    )

    daily["opening_stock"] = (
        daily["closing_stock"]
        - daily["stock_in"]
        + daily["stock_out"]
    )

    if (
        (daily["closing_stock"] < 0)
        | (daily["opening_stock"] < 0)
    ).any():
        raise ValueError(
            "Negative stock detected. "
            "Check movement dates and quantities."
        )

    daily["date_key"] = (
        daily["movement_date"]
        .dt.strftime("%Y%m%d")
        .astype(int)
    )

    print(
        "Daily snapshots calculated:",
        len(daily)
    )

    # ------------------------------------
    # 5. CONNECT TO DATA WAREHOUSE
    # ------------------------------------

    engine = get_dw_engine()

    try:

        with engine.connect() as conn:

            branch_dim = pd.read_sql(
                text("""
                    SELECT
                        branch_id,
                        branch_key
                    FROM dim_branch
                """),
                conn
            )

            product_dim = pd.read_sql(
                text("""
                    SELECT
                        product_id,
                        product_key,
                        unit_cost
                    FROM dim_product
                """),
                conn
            )

            date_dim = pd.read_sql(
                text("""
                    SELECT date_key
                    FROM dim_date
                """),
                conn
            )

        # ------------------------------------
        # 6. DIMENSION LOOKUPS
        # ------------------------------------

        daily = daily.merge(
            branch_dim,
            on="branch_id",
            how="left",
            validate="many_to_one"
        )

        daily = daily.merge(
            product_dim,
            on="product_id",
            how="left",
            validate="many_to_one"
        )

        required = [
            "branch_key",
            "product_key",
            "unit_cost"
        ]

        for column in required:

            if daily[column].isna().any():
                raise ValueError(
                    f"Missing dimension lookup: {column}"
                )

        if not daily["date_key"].isin(
            date_dim["date_key"]
        ).all():
            raise ValueError(
                "Inventory date missing from dim_date"
            )

        print("Dimension lookups completed")

        # ------------------------------------
        # 7. PREPARE WAREHOUSE RECORDS
        # ------------------------------------

        rows = []

        for _, r in daily.iterrows():

            closing = int(r["closing_stock"])

            unit_cost = Decimal(
                str(r["unit_cost"])
            )

            stock_value = (
                Decimal(closing) * unit_cost
            ).quantize(
                Decimal("0.01"),
                rounding=ROUND_HALF_UP
            )

            rows.append({

                "date_key": int(r["date_key"]),

                "branch_key": int(r["branch_key"]),

                "product_key": int(r["product_key"]),

                "opening_stock": int(
                    r["opening_stock"]
                ),

                "stock_in": int(
                    r["stock_in"]
                ),

                "stock_out": int(
                    r["stock_out"]
                ),

                "closing_stock": closing,

                "stock_value": stock_value

            })

        print(
            "Warehouse records prepared:",
            len(rows)
        )

        # ------------------------------------
        # 8. PREVENT EMPTY REFRESH
        # ------------------------------------

        if not rows:
            raise ValueError(
                "No inventory snapshots generated. "
                "Refresh aborted."
            )

        # ------------------------------------
        # 9. INSERT SQL
        # ------------------------------------

        insert_sql = text("""
            INSERT INTO fact_inventory (
                date_key,
                branch_key,
                product_key,
                opening_stock,
                stock_in,
                stock_out,
                closing_stock,
                stock_value
            )
            VALUES (
                :date_key,
                :branch_key,
                :product_key,
                :opening_stock,
                :stock_in,
                :stock_out,
                :closing_stock,
                :stock_value
            )
            ON DUPLICATE KEY UPDATE
                opening_stock = VALUES(opening_stock),
                stock_in = VALUES(stock_in),
                stock_out = VALUES(stock_out),
                closing_stock = VALUES(closing_stock),
                stock_value = VALUES(stock_value)
        """)

        # ------------------------------------
        # 10. CONTROLLED FULL INVENTORY REFRESH
        # ------------------------------------

        with engine.begin() as conn:

            # Verify backup table exists
            backup_exists = conn.execute(
                text("""
                    SELECT COUNT(*)
                    FROM information_schema.tables
                    WHERE table_schema = DATABASE()
                    AND table_name =
                        'fact_inventory_refresh_backup'
                """)
            ).scalar_one()

            if not backup_exists:
                raise RuntimeError(
                    "Backup table missing. "
                    "Create fact_inventory_refresh_backup "
                    "in MySQL Workbench first."
                )

            # Count existing inventory records
            previous_count = conn.execute(
                text("""
                    SELECT COUNT(*)
                    FROM fact_inventory
                """)
            ).scalar_one()

            # Clear previous backup
            conn.execute(text("""
                DELETE FROM fact_inventory_refresh_backup
            """))

            # Backup existing warehouse inventory
            conn.execute(text("""
                INSERT INTO fact_inventory_refresh_backup
                SELECT * FROM fact_inventory
            """))

            # Verify backup count
            backup_count = conn.execute(
                text("""
                    SELECT COUNT(*)
                    FROM fact_inventory_refresh_backup
                """)
            ).scalar_one()

            if backup_count != previous_count:
                raise ValueError(
                    "Inventory backup verification failed."
                )

            # Delete old inventory snapshots
            conn.execute(text("""
                DELETE FROM fact_inventory
            """))

            # Insert recalculated snapshots
            conn.execute(insert_sql, rows)

            # Verify new inventory records
            current_count = conn.execute(
                text("""
                    SELECT COUNT(*)
                    FROM fact_inventory
                """)
            ).scalar_one()

            if current_count != len(rows):
                raise ValueError(
                    "Inventory refresh verification failed. "
                    f"Expected {len(rows)}, "
                    f"found {current_count}"
                )

        # ------------------------------------
        # 11. REFRESH SUMMARY
        # ------------------------------------

        print("\n====================================")
        print("INVENTORY REFRESH SUMMARY")
        print("====================================")

        print("CSV movements:", len(df))

        print("Daily snapshots:", len(daily))

        print("Previous inventory records:", previous_count)

        print("Backup records:", backup_count)

        print("Current inventory records:", current_count)

        print("Inventory refresh completed successfully!")

        print("====================================")
        print("SuperMart Fact Inventory ETL Completed")
        print("====================================")

    except Exception as error:

        print("\nInventory ETL failed!")
        print("Error:", error)

        raise

    finally:

        engine.dispose()


# ------------------------------------
# MAIN EXECUTION
# ------------------------------------

if __name__ == "__main__":
    load_fact_inventory()

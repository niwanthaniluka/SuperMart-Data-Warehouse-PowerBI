
import pandas as pd
from decimal import Decimal, ROUND_HALF_UP
from sqlalchemy import text

from db_connection import (
    get_pos_engine,
    get_product_engine,
    get_dw_engine
)


def money(value):
    return Decimal(str(value)).quantize(
        Decimal("0.01"),
        rounding=ROUND_HALF_UP
    )


def load_fact_sales():

    pos_engine = get_pos_engine()
    product_engine = get_product_engine()
    dw_engine = get_dw_engine()

    try:
        print("\nSuperMart Fact Sales ETL Started")

        # -----------------------------------------
        # EXTRACT POS SALES
        # -----------------------------------------

        sales_query = """
            SELECT
                si.sale_item_id,
                si.sale_id,
                si.product_id,
                si.quantity,
                si.unit_price,
                si.discount_amount,
                si.line_total,
                s.branch_id,
                s.customer_id,
                s.sale_date,
                s.sale_status,
                p.payment_method
            FROM sale_items si
            JOIN sales s
                ON si.sale_id = s.sale_id
            LEFT JOIN (
                SELECT
                    sale_id,
                    MIN(payment_method) AS payment_method
                FROM payments
                GROUP BY sale_id
            ) p
                ON s.sale_id = p.sale_id
            WHERE s.sale_status = 'Completed'
        """

        sales_df = pd.read_sql(
            sales_query,
            pos_engine
        )

        print("POS records extracted:", len(sales_df))

        # -----------------------------------------
        # EXTRACT PRODUCT COSTS
        # -----------------------------------------

        product_query = """
            SELECT
                product_id,
                unit_cost
            FROM products
        """

        products_df = pd.read_sql(
            product_query,
            product_engine
        )

        # -----------------------------------------
        # TRANSFORM - JOIN COSTS
        # -----------------------------------------

        df = sales_df.merge(
            products_df,
            on="product_id",
            how="left",
            validate="many_to_one"
        )

        if df["unit_cost"].isna().any():
            raise ValueError(
                "Some products do not have cost values."
            )

        # -----------------------------------------
        # LOAD DIMENSION LOOKUPS
        # -----------------------------------------

        with dw_engine.connect() as conn:

            branch_dim = pd.read_sql(
                text("SELECT branch_id, branch_key FROM dim_branch"),
                conn
            )

            customer_dim = pd.read_sql(
                text("SELECT customer_id, customer_key FROM dim_customer"),
                conn
            )

            product_dim = pd.read_sql(
                text("SELECT product_id, product_key FROM dim_product"),
                conn
            )

            payment_dim = pd.read_sql(
                text("SELECT payment_method, payment_key FROM dim_payment"),
                conn
            )

            date_dim = pd.read_sql(
                text("SELECT date_key FROM dim_date"),
                conn
            )

        df["date_key"] = pd.to_datetime(
            df["sale_date"]
        ).dt.strftime("%Y%m%d").astype(int)

        df = df.merge(
            branch_dim,
            on="branch_id",
            how="left",
            validate="many_to_one"
        )

        df = df.merge(
            customer_dim,
            on="customer_id",
            how="left",
            validate="many_to_one"
        )

        df = df.merge(
            product_dim,
            on="product_id",
            how="left",
            validate="many_to_one"
        )

        df = df.merge(
            payment_dim,
            on="payment_method",
            how="left",
            validate="many_to_one"
        )

        # Validate required foreign keys
        required_keys = [
            "branch_key",
            "product_key"
        ]

        for key in required_keys:
            if df[key].isna().any():
                raise ValueError(
                    f"Missing dimension lookup: {key}"
                )

        valid_dates = set(date_dim["date_key"])

        if not df["date_key"].isin(valid_dates).all():
            raise ValueError(
                "Some sale dates are missing from dim_date."
            )

        # -----------------------------------------
        # CALCULATE FACT MEASURES
        # -----------------------------------------

        rows = []

        for _, r in df.iterrows():

            quantity = int(r["quantity"])
            unit_price = money(r["unit_price"])
            discount = money(r["discount_amount"])
            unit_cost = money(r["unit_cost"])

            gross = money(quantity * unit_price)
            net = money(gross - discount)
            cost = money(quantity * unit_cost)
            profit = money(net - cost)

            # Data quality validation
            if quantity <= 0:
                raise ValueError("Invalid sales quantity")

            if discount < 0 or discount > gross:
                raise ValueError("Invalid discount")

            if abs(net - money(r["line_total"])) > Decimal("0.01"):
                raise ValueError(
                    f"Line total mismatch: sale_item_id={r['sale_item_id']}"
                )

            rows.append({
                "sale_id": int(r["sale_id"]),
                "sale_item_id": int(r["sale_item_id"]),
                "date_key": int(r["date_key"]),
                "branch_key": int(r["branch_key"]),
                "customer_key": (
                    None if pd.isna(r["customer_key"])
                    else int(r["customer_key"])
                ),
                "product_key": int(r["product_key"]),
                "payment_key": (
                    None if pd.isna(r["payment_key"])
                    else int(r["payment_key"])
                ),
                "quantity": quantity,
                "unit_price": unit_price,
                "gross_amount": gross,
                "discount_amount": discount,
                "net_amount": net,
                "cost_amount": cost,
                "profit_amount": profit
            })

        # -----------------------------------------
        # LOAD / REFRESH FACT SALES
        # -----------------------------------------

        insert_sql = text("""
            INSERT INTO fact_sales (
                sale_id,
                sale_item_id,
                date_key,
                branch_key,
                customer_key,
                product_key,
                payment_key,
                quantity,
                unit_price,
                gross_amount,
                discount_amount,
                net_amount,
                cost_amount,
                profit_amount
            )
            VALUES (
                :sale_id,
                :sale_item_id,
                :date_key,
                :branch_key,
                :customer_key,
                :product_key,
                :payment_key,
                :quantity,
                :unit_price,
                :gross_amount,
                :discount_amount,
                :net_amount,
                :cost_amount,
                :profit_amount
            )
            ON DUPLICATE KEY UPDATE
                sale_id = VALUES(sale_id),
                date_key = VALUES(date_key),
                branch_key = VALUES(branch_key),
                customer_key = VALUES(customer_key),
                product_key = VALUES(product_key),
                payment_key = VALUES(payment_key),
                quantity = VALUES(quantity),
                unit_price = VALUES(unit_price),
                gross_amount = VALUES(gross_amount),
                discount_amount = VALUES(discount_amount),
                net_amount = VALUES(net_amount),
                cost_amount = VALUES(cost_amount),
                profit_amount = VALUES(profit_amount)
        """)

        with dw_engine.begin() as conn:
            if rows:
                conn.execute(insert_sql, rows)

        print("Fact sales records processed:", len(rows))
        print("Fact Sales ETL completed successfully!")

    finally:
        pos_engine.dispose()
        product_engine.dispose()
        dw_engine.dispose()


if __name__ == "__main__":
    load_fact_sales()

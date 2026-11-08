
import pandas as pd
from sqlalchemy import text

from db_connection import (
    get_pos_engine,
    get_product_engine,
    get_dw_engine
)


# --------------------------------------------------
# DATABASE CONNECTIONS
# --------------------------------------------------

pos_engine = get_pos_engine()
product_engine = get_product_engine()
dw_engine = get_dw_engine()


# --------------------------------------------------
# LOAD BRANCH DIMENSION
# --------------------------------------------------

def load_dim_branch():

    print("\nLoading dim_branch...")

    query = """
        SELECT
            branch_id,
            branch_name,
            city,
            address
        FROM branches
    """

    df = pd.read_sql(query, pos_engine)

    sql = text("""
        INSERT INTO dim_branch
        (branch_id, branch_name, city, address)
        VALUES
        (:branch_id, :branch_name, :city, :address)
        ON DUPLICATE KEY UPDATE
            branch_name = VALUES(branch_name),
            city = VALUES(city),
            address = VALUES(address)
    """)

    with dw_engine.begin() as conn:
        conn.execute(sql, df.to_dict("records"))

    print(f"dim_branch: {len(df)} source records processed")


# --------------------------------------------------
# LOAD CUSTOMER DIMENSION
# --------------------------------------------------

def load_dim_customer():

    print("\nLoading dim_customer...")

    query = """
        SELECT
            customer_id,
            customer_name,
            gender,
            city,
            registered_at
        FROM customers
    """

    df = pd.read_sql(query, pos_engine)

    sql = text("""
        INSERT INTO dim_customer
        (customer_id, customer_name, gender,
         city, registered_at)
        VALUES
        (:customer_id, :customer_name, :gender,
         :city, :registered_at)
        ON DUPLICATE KEY UPDATE
            customer_name = VALUES(customer_name),
            gender = VALUES(gender),
            city = VALUES(city),
            registered_at = VALUES(registered_at)
    """)

    with dw_engine.begin() as conn:
        conn.execute(sql, df.to_dict("records"))

    print(f"dim_customer: {len(df)} source records processed")


# --------------------------------------------------
# LOAD PRODUCT DIMENSION
# --------------------------------------------------

def load_dim_product():

    print("\nLoading dim_product...")

    query = """
        SELECT
            p.product_id,
            p.product_name,
            c.category_name,
            s.supplier_name,
            p.brand,
            p.unit_cost,
            p.selling_price,
            p.reorder_level,
            p.is_active
        FROM products p
        JOIN categories c
            ON p.category_id = c.category_id
        JOIN suppliers s
            ON p.supplier_id = s.supplier_id
    """

    df = pd.read_sql(query, product_engine)

    sql = text("""
        INSERT INTO dim_product
        (product_id, product_name, category_name,
         supplier_name, brand, unit_cost,
         selling_price, reorder_level, is_active)
        VALUES
        (:product_id, :product_name, :category_name,
         :supplier_name, :brand, :unit_cost,
         :selling_price, :reorder_level, :is_active)
        ON DUPLICATE KEY UPDATE
            product_name = VALUES(product_name),
            category_name = VALUES(category_name),
            supplier_name = VALUES(supplier_name),
            brand = VALUES(brand),
            unit_cost = VALUES(unit_cost),
            selling_price = VALUES(selling_price),
            reorder_level = VALUES(reorder_level),
            is_active = VALUES(is_active)
    """)

    with dw_engine.begin() as conn:
        conn.execute(sql, df.to_dict("records"))

    print(f"dim_product: {len(df)} source records processed")


# --------------------------------------------------
# LOAD PAYMENT DIMENSION
# --------------------------------------------------

def load_dim_payment():

    print("\nLoading dim_payment...")

    methods = [
        {"payment_method": "Cash"},
        {"payment_method": "Card"},
        {"payment_method": "Bank Transfer"},
        {"payment_method": "Digital Wallet"}
    ]

    sql = text("""
        INSERT INTO dim_payment (payment_method)
        VALUES (:payment_method)
        ON DUPLICATE KEY UPDATE
            payment_method = VALUES(payment_method)
    """)

    with dw_engine.begin() as conn:
        conn.execute(sql, methods)

    print("dim_payment: 4 payment methods processed")


# --------------------------------------------------
# LOAD DATE DIMENSION
# --------------------------------------------------

def load_dim_date():

    print("\nLoading dim_date...")

    dates = pd.date_range(
        start="2026-01-01",
        end="2026-12-31",
        freq="D"
    )

    rows = []

    for d in dates:

        rows.append({
            "date_key": int(d.strftime("%Y%m%d")),
            "full_date": d.date(),
            "day_number": d.day,
            "month_number": d.month,
            "month_name": d.strftime("%B"),
            "quarter_number": d.quarter,
            "year_number": d.year,
            "day_name": d.strftime("%A")
        })

    sql = text("""
        INSERT INTO dim_date
        (date_key, full_date, day_number,
         month_number, month_name,
         quarter_number, year_number, day_name)
        VALUES
        (:date_key, :full_date, :day_number,
         :month_number, :month_name,
         :quarter_number, :year_number, :day_name)
        ON DUPLICATE KEY UPDATE
            full_date = VALUES(full_date),
            day_number = VALUES(day_number),
            month_number = VALUES(month_number),
            month_name = VALUES(month_name),
            quarter_number = VALUES(quarter_number),
            year_number = VALUES(year_number),
            day_name = VALUES(day_name)
    """)

    with dw_engine.begin() as conn:
        conn.execute(sql, rows)

    print(f"dim_date: {len(rows)} calendar records processed")


# --------------------------------------------------
# MAIN ETL
# --------------------------------------------------

def main():

    print("===================================")
    print("SuperMart Dimension ETL Started")
    print("===================================")

    try:
        load_dim_branch()
        load_dim_customer()
        load_dim_product()
        load_dim_payment()
        load_dim_date()

        print("\n===================================")
        print("ALL DIMENSIONS LOADED SUCCESSFULLY")
        print("===================================")

    finally:
        pos_engine.dispose()
        product_engine.dispose()
        dw_engine.dispose()


if __name__ == "__main__":
    main()

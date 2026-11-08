
import pandas as pd

from db_connection import (
    get_pos_engine,
    get_product_engine,
    get_dw_engine
)


pos_engine = get_pos_engine()
product_engine = get_product_engine()
dw_engine = get_dw_engine()

try:
    print("\n--- POS SOURCE ---")
    sales = pd.read_sql(
        "SELECT * FROM sales LIMIT 5",
        pos_engine
    )
    print(sales)

    print("\n--- PRODUCT SOURCE ---")
    products = pd.read_sql(
        "SELECT * FROM products LIMIT 5",
        product_engine
    )
    print(products)

    print("\n--- DATA WAREHOUSE ---")
    dimensions = pd.read_sql(
        "SELECT COUNT(*) AS total FROM dim_product",
        dw_engine
    )
    print(dimensions)

finally:
    pos_engine.dispose()
    product_engine.dispose()
    dw_engine.dispose()

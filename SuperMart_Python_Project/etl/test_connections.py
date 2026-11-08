
from sqlalchemy import text

from db_connection import (
    get_pos_engine,
    get_product_engine,
    get_dw_engine
)


databases = {
    "Source 01 - POS": get_pos_engine(),
    "Source 02 - Products": get_product_engine(),
    "Destination - Warehouse": get_dw_engine()
}


print("\nSuperMart MySQL Connection Test")
print("--------------------------------")

for name, engine in databases.items():
    try:
        with engine.connect() as connection:
            result = connection.execute(
                text("SELECT DATABASE()")
            )

            database_name = result.scalar()

            print(f"[SUCCESS] {name}")
            print(f"          Database: {database_name}")

    except Exception as error:
        print(f"[FAILED] {name}")
        print(f"Reason: {error}")

    finally:
        engine.dispose()

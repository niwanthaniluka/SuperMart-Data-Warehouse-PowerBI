
from pathlib import Path
import os

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# Load .env from project root
BASE_DIR = Path(__file__).resolve().parent.parent
load_dotenv(BASE_DIR / ".env")


def get_engine(database_name):
    """Create a MySQL connection engine."""

    connection_url = URL.create(
        drivername="mysql+pymysql",
        username=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", "3306")),
        database=database_name
    )

    engine = create_engine(
        connection_url,
        pool_pre_ping=True
    )

    return engine


def get_pos_engine():
    return get_engine(os.getenv("POS_DB"))


def get_product_engine():
    return get_engine(os.getenv("PRODUCT_DB"))


def get_dw_engine():
    return get_engine(os.getenv("DW_DB"))

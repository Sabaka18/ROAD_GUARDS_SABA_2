import os
import mysql.connector
from mysql.connector import Error

# ─────────────────────────────────────────────
# These values come from environment variables
# Set them in Render dashboard — never hardcode
# ─────────────────────────────────────────────
DB_HOST     = os.getenv("DB_HOST")
DB_PORT     = int(os.getenv("DB_PORT", 3306))
DB_NAME     = os.getenv("DB_NAME")
DB_USER     = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


def get_connection():
    """Returns a MySQL connection. Call .close() when done."""
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            port=DB_PORT,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            connection_timeout=10
        )
        return conn
    except Error as e:
        raise RuntimeError(f"Database connection failed: {e}")

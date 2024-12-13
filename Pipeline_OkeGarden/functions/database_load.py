import pandas as pd
import numpy as np
import mysql.connector
from mysql.connector import Error
import os
import warnings
warnings.filterwarnings("ignore")

# --- Functions Load Database---
def load_credentials():
    """
    Load MySQL credentials from environment variables or a secure file.
    """
    return {
        "host": os.getenv("MYSQL_HOST", "okegarden-laravel-prod-db-2024-11-15-0200.cgwhhgh85mr3.ap-southeast-3.rds.amazonaws.com"),
        "port": os.getenv("MYSQL_PORT", "3306"),
        "user": os.getenv("MYSQL_USER", "intern_mes"),
        "password": os.getenv("MYSQL_PASSWORD", "sdfDFLES342982Ddlsdksd"),
        "database": os.getenv("MYSQL_DATABASE", "okegarden_laravel_prod_db")
    }

# Function fetch data
def fetch_data(query, params=None):
    """
    Fetch data from MySQL database and return it as a DataFrame.
    """
    credentials = load_credentials()
    try:
        connection = mysql.connector.connect(
            host=credentials["host"],
            port=credentials["port"],
            user=credentials["user"],
            password=credentials["password"],
            database=credentials["database"]
        )
        # Execute query and return as DataFrame
        data = pd.read_sql(query, con=connection, params=params)
        connection.close()
        return data
    except Error as e:
        print(f"Error while connecting to MySQL: {e}")
        return None

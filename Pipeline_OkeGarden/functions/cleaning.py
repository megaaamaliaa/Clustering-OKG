import pandas as pd
import numpy as np
import mysql.connector
from mysql.connector import Error


# Function menghapus data yang tidak terpakai, contoh id yang tidak digunakan
def remove_ids_from_dataframe(df: pd.DataFrame, column_name: str, ids_to_remove: list) -> pd.DataFrame:
    """
    Remove rows from a DataFrame based on specific IDs in a given column.

    Parameters:
        df (pd.DataFrame): The input DataFrame.
        column_name (str): The name of the column to check for IDs.
        ids_to_remove (list): A list of IDs to be removed.

    Returns:
        pd.DataFrame: The cleaned DataFrame.
    """
    return df[~df[column_name].isin(ids_to_remove)]



# function impute coloum missing values dengan string 
def fill_missing_values(df: pd.DataFrame, column_name: str, fill_value: str ) -> pd.DataFrame:
    """

    Parameters:
        df (pd.DataFrame): The input DataFrame.
        column_name (str): The column to fill missing values in.
        fill_value (str): The value to use for filling missing values.

    Returns:
        pd.DataFrame: The DataFrame with missing values filled.
    """
    df[column_name] = df[column_name].fillna(fill_value)
    return df

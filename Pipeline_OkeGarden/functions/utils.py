import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
import os

#  Function cek missing values
def cek_missing_values(dataframe):
    """
    Fungsi untuk memeriksa missing values dalam DataFrame.
    
    """
    # Menghitung jumlah nilai yang hilang (missing values) per kolom
    missing_count = dataframe.isna().sum()
    return missing_count

#  Function handling missing values and scale data (drop row with missing values)
def preprocess_data(data):
    """
    Perform data preprocessing such as scaling, cleaning, and handling missing values.
    """
    # Example: Handle missing values and scale data
    data = data.dropna()  # Drop rows with missing values
    return data

#  Function find outliers
def find_outlier(data):
    """
    Find outliers in the data using the IQR method.

    Parameters:
        data (array-like): Input numerical data.
    """
    Q1 = np.quantile(data, .25)
    Q2 = np.quantile(data, .50)  # Median
    Q3 = np.quantile(data, .75)

    # Find IQR
    IQR = (Q3 - Q1) * 1.5
    lower_limit = Q1 - IQR
    upper_limit = Q3 + IQR

    # Find outliers
    outliers = ''
    for i in range(len(data)):
        if data[i] > upper_limit:
            outliers = outliers + str(data[i]) + ', '

        elif data[i] < lower_limit:
            outliers = outliers + str(data[i]) + ', '

    return outliers
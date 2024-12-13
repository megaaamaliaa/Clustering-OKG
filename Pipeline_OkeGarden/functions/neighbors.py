import pandas as pd
import numpy as np
from sklearn.neighbors import NearestNeighbors
from geopy.distance import geodesic

# Function untuk mencari tetangga atau neighbors terdekat dan menambahkan hasilnya ke data 
def calculate_nearest_neighbors(dataframe, lat_col, lng_col, id_col, n_neighbors=3, max_distance=10000):
    """
    Fungsi untuk mencari tetangga terdekat berdasarkan jarak, serta memfilter berdasarkan jarak maksimum.
    
    Parameters:
        dataframe (pd.DataFrame): Dataframe yang berisi data lokasi.
        lat_col (str): Nama kolom untuk data latitude.
        lng_col (str): Nama kolom untuk data longitude.
        id_col (str): Nama kolom untuk ID unik setiap titik.
        n_neighbors (int): Jumlah tetangga terdekat yang dicari.
        max_distance (float): Jarak maksimum untuk tetangga (dalam meter).
        
    Returns:
        pd.DataFrame: Dataframe dengan tambahan kolom valid_neighbors dan valid_distances.
    """
    
    # Memastikan DataFrame memiliki kolom yang dibutuhkan
    if lat_col not in dataframe or lng_col not in dataframe or id_col not in dataframe:
        raise ValueError("DataFrame tidak memiliki kolom yang diperlukan!")

    # Variabel Fitur
    X = dataframe[[lat_col, lng_col]]

    # Model KNN
    knn = NearestNeighbors(n_neighbors=n_neighbors, metric='euclidean')
    knn.fit(X)

    # Mendapatkan n tetangga terdekat
    distances, indices = knn.kneighbors(X)

    # Fungsi untuk menghitung jarak antar dua titik (menggunakan geopy)
    def calculate_distance(lat1, lng1, lat2, lng2):
        return geodesic((lat1, lng1), (lat2, lng2)).meters  # Menghitung jarak dalam meter

    # Menambahkan neighbors dan jarak ke tabel
    dataframe['neighbors'] = [
        dataframe[id_col].iloc[neighbors].values.tolist() for neighbors in indices
    ]

    # Menambahkan kolom jarak
    dataframe['neighbor_distances'] = [
        [distances[i][j] for j in range(len(distances[i]))] for i in range(len(distances))
    ]

    # Menentukan tetangga yang berada dalam jarak maksimum
    valid_neighbors_list = []
    valid_distances_list = []

    for i, row in dataframe.iterrows():
        valid_neighbors = []
        valid_distances = []
        for j, neighbor_id in enumerate(row['neighbors']):
            # Mendapatkan data untuk neighbor
            neighbor_row = dataframe[dataframe[id_col] == neighbor_id]
            if not neighbor_row.empty:
                neighbor_lat = neighbor_row.iloc[0][lat_col]
                neighbor_lng = neighbor_row.iloc[0][lng_col]
                
                # Menghitung jarak antar titik
                distance = calculate_distance(row[lat_col], row[lng_col], neighbor_lat, neighbor_lng)
                
                # Memeriksa apakah jarak dalam batas yang ditentukan
                if distance <= max_distance:
                    valid_neighbors.append(neighbor_id)
                    valid_distances.append(distance)
        
        # Menambahkan valid_neighbors dan valid_distances ke list
        valid_neighbors_list.append(valid_neighbors)
        valid_distances_list.append(valid_distances)

    # Menambahkan valid_neighbors dan valid_distances ke DataFrame
    dataframe['valid_neighbors'] = valid_neighbors_list
    dataframe['valid_distances'] = valid_distances_list

    return dataframe


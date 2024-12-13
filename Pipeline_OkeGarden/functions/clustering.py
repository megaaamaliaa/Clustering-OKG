import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans, DBSCAN
from sklearn.preprocessing import StandardScaler


#  Function menghitung inertia untuk menentukan k value menggunakan elbow method
def calculate_inertia(data, feature_cols):
    """
    Calculate inertia values for different numbers of clusters.
    """

    # Normalisasi data
    scaler = StandardScaler()
    scaled_features = scaler.fit_transform(data[feature_cols])

    # Find inertia values for k=1 to 9
    k = range(1, 10)
    inertia = []
    for i in k: 
        model = KMeans(n_clusters=i, random_state=42 )
        model.fit(scaled_features)
        inertia.append(model.inertia_)
        
    # Plot elbow graph
    plt.plot(k, inertia, "o-")
    plt.xlabel("k value")
    plt.ylabel("Inertia (sum squared error)")
    plt.title("Elbow Method for Optimal k")
    plt.show()

    return inertia
    
    
#  Function membuat cluster dan menambahkan cluster ke data
def perform_clustering(data, feature_cols, n_clusters=None, max_iter=1000):

    # Normalisasi data
    scaler = StandardScaler()
    scaled_features = scaler.fit_transform(data[feature_cols])

    # Fit KMeans model with the specified number of clusters
    model = KMeans(n_clusters=n_clusters, max_iter=max_iter, random_state=42)
    model.fit(scaled_features)

    # Add cluster 
    data["cluster"] = model.predict(scaled_features)

    return data



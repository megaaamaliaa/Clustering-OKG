import matplotlib.pyplot as plt
import seaborn as sns
import folium

# Function visualization barplot
def barplot_visualization(data, x_col, y_col, title, xlabel, ylabel):
    """
    Plot a barplot for sales count.

    Parameters:
    - data: pandas DataFrame containing the data.
    - x_col: str, the column name for the x-axis.
    - y_col: str, the column name for the y-axis.
    - title: str, the title of the plot.
    - xlabel: str, label for the x-axis 
    - ylabel: str, label for the y-axis 
    """
    plt.figure(figsize=(10, 6))
    ax = sns.barplot(data=data, x=x_col, y=y_col, palette='viridis')

    # Add title and labels
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)

    # Add numerical annotations on the bars
    for p in ax.patches:
        ax.annotate(f'{p.get_height():.0f}',
                    (p.get_x() + p.get_width() / 2.0, p.get_height()),
                    textcoords='offset points', xytext=(0, 3),
                    ha='center', fontsize=10, color='black')

    # Show the plot
    plt.show()


# Function visualization lineplot
def lineplot_visualization(data, x_col, y_col, hue_col, title, xlabel, ylabel):
    """
    Plot a line plot for monthly sales count per cluster.

    Parameters:
    - data: pandas DataFrame containing the data.
    - x_col: str, the column name for the x-axis (e.g., 'month').
    - y_col: str, the column name for the y-axis (e.g., 'sales_count').
    - hue_col: str, the column name for grouping (e.g., 'cluster').
    - title: str, the title of the plot.
    - xlabel: str, label for the x-axis.
    - ylabel: str, label for the y-axis.
    """
    plt.figure(figsize=(12, 6))
    sns.lineplot(data=data, x=x_col, y=y_col, hue=hue_col, marker='o', palette='cubehelix')
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.xticks(rotation=45)
    plt.legend(title=hue_col)
    plt.show()


#  Function visualization cluster scater plot
def visualize_clusters(data, x_col, y_col, cluster_col="Cluster"):
    """
    Visualize clusters using a scatter plot.
    """
    plt.figure(figsize=(10, 6))
    sns.scatterplot(
        data=data,
        x=x_col,
        y=y_col,
        hue=cluster_col,
        palette="viridis",
        legend="full"
    )
    plt.title("Cluster Visualization")
    plt.show()



#  Function membuat visualization map berdasarkan cluster
def create_cluster_map(data, cluster_col, id_col, lat_col, lng_col, neighbors_col, distances_col, address_col):
    """
    Membuat peta interaktif menggunakan Folium dengan marker berdasarkan cluster.

    Parameters:
    - data: DataFrame, data input
    - cluster_col: str, nama kolom untuk cluster
    - id_col: str, nama kolom untuk ID
    - lat_col: str, nama kolom untuk latitude
    - lng_col: str, nama kolom untuk longitude
    - neighbors_col: str, nama kolom yang berisi tetangga valid
    - distances_col: str, nama kolom yang berisi jarak ke tetangga
    - address_col: str, nama kolom untuk alamat

    Returns:
    - folium.Map: Peta yang dihasilkan
    """
    # Hitung lokasi pusat
    center_lat = data[lat_col].mean()
    center_lng = data[lng_col].mean()

    # Buat peta
    mymap = folium.Map(location=[center_lat, center_lng], zoom_start=15)

    # Warna untuk cluster
    cluster_colors = ['red', 'blue', 'green', 'purple', 'orange', 'darkred', 'lightblue', 'lightgreen']
    color_mapping = {}

    # Tetapkan warna untuk setiap cluster
    unique_clusters = data[cluster_col].unique()
    for i, cluster in enumerate(unique_clusters):
        color_mapping[cluster] = cluster_colors[i % len(cluster_colors)]

    # Tambahkan marker untuk setiap titik
    for _, row in data.iterrows():
        cluster = row[cluster_col]
        color = color_mapping.get(cluster, 'gray')
        folium.Marker(
            location=[row[lat_col], row[lng_col]],
            popup=(
                f"ID: {row[id_col]}<br>"
                f"Neighbors: {row[neighbors_col]}<br>"
                f"Address: {row[address_col]}"
            ),
            icon=folium.Icon(color=color)
        ).add_to(mymap)

    # Tambahkan garis antara titik-titik yang bertetangga
    for _, row in data.iterrows():
        neighbors = row[neighbors_col]
        distances = row[distances_col]

        if isinstance(neighbors, list) and isinstance(distances, list):
            for neighbor_id in neighbors:
                neighbor_row = data[data[id_col] == neighbor_id]
                if not neighbor_row.empty:
                    neighbor_lat = neighbor_row.iloc[0][lat_col]
                    neighbor_lng = neighbor_row.iloc[0][lng_col]

                    folium.PolyLine(
                        locations=[[row[lat_col], row[lng_col]], [neighbor_lat, neighbor_lng]],
                        color='blue',
                        weight=2.5,
                        opacity=0.7
                    ).add_to(mymap)

    return mymap
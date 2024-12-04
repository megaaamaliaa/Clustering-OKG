# Card Dashboard Metabase
# sales_count per cluster
SELECT 
	cluster ,
	COUNT(id) as sales_count 
FROM 
	data_order_garden_care_clustering
GROUP BY
	cluster ;

# Revenue per cluster
SELECT 
	cluster ,
	SUM(price) as revenue 
FROM
	data_order_garden_care_clustering
GROUP BY
	cluster ;

# jumlah perawatan taman per cluster
SELECT 
	cluster ,
	SUM(jumlah_perawatan) as jumlah_perawatan_taman
FROM 
	data_order_garden_care_clustering dogcc 
GROUP BY
	cluster ;

# jumlah tenaga kerja per cluster
SELECT 
	cluster ,
	SUM(manpower_required) as jumlah_tenaga_kerja 
FROM 
	data_order_garden_care_clustering dogcc 
GROUP BY
	cluster ;

# Monthly sales per cluster
SELECT 
	cluster ,
	COUNT(id) as sales_count,
	month
FROM 
	data_order_garden_care_clustering
WHERE 
	month
GROUP BY
	cluster,
	month ;

# Monthly ravenue per cluster
SELECT 
	cluster ,
	SUM(price) as revenue,
	month
FROM 
	data_order_garden_care_clustering
WHERE 
	month
GROUP BY
	cluster,
	month ;
	

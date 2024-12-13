# Card Dashboard Metabase

# Key Metrics Order Garden Care

-- jumlah perawatan
SELECT 
    SUM(jumlah_perawatan) AS total_care_care
FROM 
    order_garden_care_clustering_new
    JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE 
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
    

-- total manpower
SELECT 
    SUM(manpower_required) AS total_manpower_required
FROM 
    order_garden_care_clustering_new
    JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE 
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
    
-- Total Unscheduled Garden Care 
SELECT 
    COUNT(1)
FROM 
    order_garden_care_clustering_new
    JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}  
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
    
# Key Metrics Order Garden

-- Total Garden 
SELECT 
    COUNT(1)
FROM 
    `order_garden_clustering_new`
    JOIN address_components_order_garden  ON order_garden_clustering_new.address_componentable_id = address_components_order_garden.address_componentable_id
WHERE
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_clustering_new.order_date >= {{start_date}}
    AND order_garden_clustering_new.order_date <= {{end_date}};
    
-- Total size area
SELECT 
    SUM(size_area) 
FROM 
    order_garden_clustering_new
    JOIN address_components_order_garden  ON order_garden_clustering_new.address_componentable_id = address_components_order_garden.address_componentable_id
WHERE 
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_clustering_new.order_date >= {{start_date}}
    AND order_garden_clustering_new.order_date <= {{end_date}};;

--  Key Metrics Order Design
   
--    Total Order Garden Design
SELECT 
    COUNT(1)
FROM 
    `order_design_clustering_new`
     JOIN address_components_order_design  ON order_design_clustering_new.address_componentable_id = address_components_order_design.address_componentable_id
WHERE
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_design_clustering_new.order_date >= {{start_date}}
    AND order_design_clustering_new.order_date <= {{end_date}};
    
   
-- Overview Garden Care

--    Care Count by Cluster
SELECT 
	cluster ,
	SUM(jumlah_perawatan) 
FROM 
	order_garden_care_clustering_new
WHERE 
    {{code}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
GROUP BY
	cluster ;

-- Cluster Overview
SELECT
  `order_garden_care_clustering_new`.`id` AS `id`,
  `order_garden_care_clustering_new`.`id_order_garden_care` AS `id_order_garden_care`,
  `order_garden_care_clustering_new`.`status` AS `status`,
  `order_garden_care_clustering_new`.`id_user` AS `id_user`,
  `order_garden_care_clustering_new`.`price` AS `price`,
  `order_garden_care_clustering_new`.`code` AS `code`,
  `order_garden_care_clustering_new`.`size` AS `size`,
  `order_garden_care_clustering_new`.`jumlah_perawatan` AS `jumlah_perawatan`,
  `order_garden_care_clustering_new`.`manpower_required` AS `manpower_required`,
  `order_garden_care_clustering_new`.`address` AS `address`,
  `order_garden_care_clustering_new`.`address_componentable_id` AS `address_componentable_id`,
  `order_garden_care_clustering_new`.`lat` AS `lat`,
  `order_garden_care_clustering_new`.`lng` AS `lng`,
  `order_garden_care_clustering_new`.`order_date` AS `order_date`,
  `order_garden_care_clustering_new`.`cluster` AS `cluster`,
  `order_garden_care_clustering_new`.`month` AS `month`,
  `order_garden_care_clustering_new`.`sales_count` AS `sales_count`,
  `order_garden_care_clustering_new`.`neighbors` AS `neighbors`,
  `order_garden_care_clustering_new`.`neighbor_distances` AS `neighbor_distances`,
  `order_garden_care_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_garden_care_clustering_new`.`valid_distances` AS `valid_distances`
FROM
  `order_garden_care_clustering_new`
    JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE 
  {{code}}
  AND {{administrative_area_level_1}}
  AND {{administrative_area_level_2}}
  AND {{administrative_area_level_3}}
  AND order_garden_care_clustering_new.order_date >= {{start_date}}
  AND order_garden_care_clustering_new.order_date <= {{end_date}}
 
-- Cluster Location Unschedule
SELECT
  order_garden_care_clustering_new.id,
  order_garden_care_clustering_new.id_user,
  order_garden_care_clustering_new.price,
  order_garden_care_clustering_new.jumlah_perawatan AS treatment_count,
  order_garden_care_clustering_new.manpower_required,
  order_garden_care_clustering_new.address,
  order_garden_care_clustering_new.lat,
  order_garden_care_clustering_new.lng,
  order_garden_care_clustering_new.order_date,
  order_garden_care_clustering_new.cluster,
  order_garden_care_clustering_new.MONTH AS Month,
  order_garden_care_clustering_new.valid_neighbors,
  order_garden_care_clustering_new.valid_distances,
  address_components_garden_care.administrative_area_level_1 ,
  address_components_garden_care.administrative_area_level_2 ,
  address_components_garden_care.administrative_area_level_3 
FROM
  order_garden_care_clustering_new
  JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE
  lat IS NOT NULL
  AND lng IS NOT NULL
  AND {{cluster}}
  AND {{code}}
  AND {{administrative_area_level_1}}
  AND {{administrative_area_level_2}}
  AND {{administrative_area_level_3}}
  AND order_garden_care_clustering_new.order_date >= {{start_date}}
  AND order_garden_care_clustering_new.order_date <= {{end_date}}
GROUP BY id

-- Count of Packages by Sales
SELECT 
    jumlah_perawatan AS care_count,
    manpower_required,
    COUNT(*) AS sales_count
FROM 
    order_garden_care_clustering_new
WHERE 
    {{cluster}}
    AND {{code}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
GROUP BY 
    jumlah_perawatan, 
    manpower_required
    
-- Manpower by Cluster
SELECT 
	`cluster`,
	SUM (`manpower_required`) as `Manpower_Required`
FROM 
	`order_garden_care_clustering_new` 
GROUP BY
	`cluster` ;
	
-- Monthly Revenue by Cluster
SELECT
  `cluster`,
  SUM(`price`) AS `revenue`,
  MONTH
FROM
  `order_garden_care_clustering_new`
WHERE
  `month`
  AND {{code}}
GROUP BY
  `cluster`,
  `month`
  
  
-- Monthly Revenue Trend
 SELECT
  STR_TO_DATE(
    CONCAT(
      DATE_FORMAT(`order_garden_care_clustering_new`.`order_date`, '%Y-%m'),
      '-01'
    ),
    '%Y-%m-%d'
  ) AS `order_date`,
  SUM(`order_garden_care_clustering_new`.`price`) AS `sum`
FROM
  `order_garden_care_clustering_new`
  JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE
  (`order_garden_care_clustering_new`.`price` > 1)
   AND (
    `order_garden_care_clustering_new`.`order_date` >= STR_TO_DATE(
      CONCAT(
        DATE_FORMAT(DATE_ADD(NOW(6), INTERVAL -12 month), '%Y-%m'),
        '-01'
      ),
      '%Y-%m-%d'
    )
  )
  AND (
    `order_garden_care_clustering_new`.`order_date` < STR_TO_DATE(
      CONCAT(DATE_FORMAT(NOW(6), '%Y-%m'), '-01'),
      '%Y-%m-%d'
    )
  )
  AND order_garden_care_clustering_new.order_date >= {{start_date}}
  AND order_garden_care_clustering_new.order_date <= {{end_date}}
  AND {{cluster}}
  AND {{code}}
  AND {{administrative_area_level_1}}
  AND {{administrative_area_level_2}}
  AND {{administrative_area_level_3}}
GROUP BY
  STR_TO_DATE(
    CONCAT(
      DATE_FORMAT(`order_garden_care_clustering_new`.`order_date`, '%Y-%m'),
      '-01'
    ),
    '%Y-%m-%d'
  )
ORDER BY
  STR_TO_DATE(
    CONCAT(
      DATE_FORMAT(`order_garden_care_clustering_new`.`order_date`, '%Y-%m'),
      '-01'
    ),
    '%Y-%m-%d'
  ) ASC
  
-- Monthly Sales by Cluster
SELECT 
	`cluster` ,
	COUNT(`id`) as `sales_count`,
	month
FROM 
	`order_garden_care_clustering_new`
WHERE 
	`month`
	AND {{code}}
GROUP BY
	`cluster`,
	`month` ;
	
-- Revenue by Cluster
SELECT 
	`cluster` ,
	SUM(`price`) as `revenue` 
FROM
	`order_garden_care_clustering_new`
WHERE 
    {{code}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
GROUP BY
	`cluster` ;
	
-- Sales by Code Promo
SELECT 
	`code`,
	COUNT (*) 
FROM 
	`order_garden_care_clustering_new` 
	JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE
	{{cluster}}
	AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
GROUP BY
	`code`;
	
-- Sales by Cluster
SELECT 
    STR_TO_DATE(
        CONCAT(
          DATE_FORMAT(`order_garden_care_clustering_new`.`order_date`, '%Y-%m'),
          '-01'
            ),
        '%Y-%m-%d'
        ) AS `order_date`,
	`cluster` ,
	COUNT(id) as `sales_count` 
FROM 
	`order_garden_care_clustering_new`
WHERE
   (
    `order_garden_care_clustering_new`.`order_date` >= STR_TO_DATE(
      CONCAT(
        DATE_FORMAT(DATE_ADD(NOW(6), INTERVAL -12 month), '%Y-%m'),
        '-01'
      ),
      '%Y-%m-%d'
    )
  )
  AND (
    `order_garden_care_clustering_new`.`order_date` < STR_TO_DATE(
      CONCAT(DATE_FORMAT(NOW(6), '%Y-%m'), '-01'),
      '%Y-%m-%d'
    )
  )
AND order_garden_care_clustering_new.order_date >= {{start_date}}
AND order_garden_care_clustering_new.order_date <= {{end_date}}
AND {{code}}
GROUP BY
	`cluster`;
	
-- Sales by Size Category
SELECT 
	`size`,
	COUNT (*) 
FROM 
	`order_garden_care_clustering_new`
	JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE
	{{cluster}}
	AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_care_clustering_new.order_date >= {{start_date}}
    AND order_garden_care_clustering_new.order_date <= {{end_date}}
GROUP BY
	`size` ;
	
-- Tabel Neighbors
SELECT
  order_garden_care_clustering_new.id,
  order_garden_care_clustering_new.id_user,
  order_garden_care_clustering_new.price,
  order_garden_care_clustering_new.code AS code_promo,
  order_garden_care_clustering_new.cluster,
  order_garden_care_clustering_new.valid_neighbors,
  order_garden_care_clustering_new.valid_distances,
  order_garden_care_clustering_new.jumlah_perawatan AS treatment_count,
  order_garden_care_clustering_new.manpower_required,
  order_garden_care_clustering_new.address,
  order_garden_care_clustering_new.lat,
  order_garden_care_clustering_new.lng,
  order_garden_care_clustering_new.order_date,
  address_components_garden_care.administrative_area_level_1 ,
  address_components_garden_care.administrative_area_level_2 ,
  address_components_garden_care.administrative_area_level_3 
FROM
  `order_garden_care_clustering_new`
   JOIN address_components_garden_care  ON order_garden_care_clustering_new.address_componentable_id = address_components_garden_care.address_componentable_id
WHERE 
   {{cluster}}
  AND {{code}}
  AND {{administrative_area_level_1}}
  AND {{administrative_area_level_2}}
  AND {{administrative_area_level_3}}
  AND order_garden_care_clustering_new.order_date >= {{start_date}}
  AND order_garden_care_clustering_new.order_date <= {{end_date}}
ORDER BY 
    `cluster` ASC ;

-- Overview Order Garden
   
-- Cluster Overview
SELECT
  `order_garden_clustering_new`.`id_order_garden` AS `id_order_garden`,
  `order_garden_clustering_new`.`id_user` AS `id_user`,
  `order_garden_clustering_new`.`id_gardener` AS `id_gardener`,
  `order_garden_clustering_new`.`status_garden` AS `status_garden`,
  `order_garden_clustering_new`.`code` AS `code`,
  `order_garden_clustering_new`.`size_area` AS `size_area`,
  `order_garden_clustering_new`.`address` AS `address`,
  `order_garden_clustering_new`.`address_componentable_id` AS `address_componentable_id`,
  `order_garden_clustering_new`.`lat` AS `lat`,
  `order_garden_clustering_new`.`lng` AS `lng`,
  `order_garden_clustering_new`.`order_date` AS `order_date`,
  `order_garden_clustering_new`.`cluster` AS `cluster`,
  `order_garden_clustering_new`.`neighbors` AS `neighbors`,
  `order_garden_clustering_new`.`neighbor_distances` AS `neighbor_distances`,
  `order_garden_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_garden_clustering_new`.`valid_distances` AS `valid_distances`
FROM
  `order_garden_clustering_new`
    JOIN address_components_order_garden  ON order_garden_clustering_new.address_componentable_id = address_components_order_garden.address_componentable_id
WHERE
  {{code}}
  AND {{administrative_area_level_1}}
  AND {{administrative_area_level_2}}
  AND {{administrative_area_level_3}}
  AND order_garden_clustering_new.order_date >= {{start_date}}
  AND order_garden_clustering_new.order_date <= {{end_date}}
 
-- Sales by Code Promo
 SELECT 
	`code`,
	COUNT (*) 
FROM 
	`order_garden_clustering_new` 
	JOIN address_components_order_garden  ON order_garden_clustering_new.address_componentable_id = address_components_order_garden.address_componentable_id
WHERE
	{{cluster}}
	AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_clustering_new.order_date >= {{start_date}}
    AND order_garden_clustering_new.order_date <= {{end_date}}
GROUP BY
	`code`;

-- Clustering Location
SELECT
  `order_garden_clustering_new`.`id_order_garden` AS `id_order_garden`,
  `order_garden_clustering_new`.`id_user` AS `id_user`,
  `order_garden_clustering_new`.`id_gardener` AS `id_gardener`,
  `order_garden_clustering_new`.`code` AS code_promo,
  `order_garden_clustering_new`.`status_garden` AS `status_garden`,
  `order_garden_clustering_new`.`cluster` AS `cluster`,
  `order_garden_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_garden_clustering_new`.`valid_distances` AS `valid_distances`,
  `order_garden_clustering_new`.`size_area` AS `size_area`,
  `order_garden_clustering_new`.`address` AS `address`,
  `address_components_order_garden`.`administrative_area_level_1` ,
  `address_components_order_garden`.`administrative_area_level_2` ,
  `address_components_order_garden`.`administrative_area_level_3` ,
  `order_garden_clustering_new`.`lat` AS `lat`,
  `order_garden_clustering_new`.`lng` AS `lng`,
  `order_garden_clustering_new`.`order_date` AS `order_date`
FROM
  `order_garden_clustering_new`
  JOIN address_components_order_garden  ON order_garden_clustering_new.address_componentable_id = address_components_order_garden.address_componentable_id
 WHERE 
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_clustering_new.order_date >= {{start_date}}
    AND order_garden_clustering_new.order_date <= {{end_date}}

-- Size Area by Cluster
SELECT 
	`cluster`,
	SUM (`size_area`)
FROM 
	`order_garden_clustering_new` 
WHERE 
    {{code}}
    AND order_garden_clustering_new.order_date >= {{start_date}}
    AND order_garden_clustering_new.order_date <= {{end_date}}
GROUP BY
	`cluster` ;

-- Table Neighbors
SELECT
  `order_garden_clustering_new`.`id_order_garden` AS `id_order_garden`,
  `order_garden_clustering_new`.`id_user` AS `id_user`,
  `order_garden_clustering_new`.`id_gardener` AS `id_gardener`,
  `order_garden_clustering_new`.`code` AS code_promo,
  `order_garden_clustering_new`.`cluster` AS `cluster`,
  `order_garden_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_garden_clustering_new`.`valid_distances` AS `valid_distances`,
  `order_garden_clustering_new`.`size_area` AS `size_area`,
  `order_garden_clustering_new`.`address` AS `address`,
  `address_components_order_garden`.`administrative_area_level_1` ,
  `address_components_order_garden`.`administrative_area_level_2` ,
  `address_components_order_garden`.`administrative_area_level_3` ,
  `order_garden_clustering_new`.`lat` AS `lat`,
  `order_garden_clustering_new`.`lng` AS `lng`,
  `order_garden_clustering_new`.`order_date` AS `order_date`
FROM
  `order_garden_clustering_new`
  JOIN address_components_order_garden  ON order_garden_clustering_new.address_componentable_id = address_components_order_garden.address_componentable_id
 WHERE 
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_garden_clustering_new.order_date >= {{start_date}}
    AND order_garden_clustering_new.order_date <= {{end_date}};


-- Overview Order Design
   
-- Cluster Overview
SELECT
  `order_design_clustering_new`.`id_order_design` AS `id_order_design`,
  `order_design_clustering_new`.`id_user` AS `id_user`,
  `order_design_clustering_new`.`id_designer` AS `id_designer`,
  `order_design_clustering_new`.`code` AS `code`,
  `order_design_clustering_new`.`status_design` AS `status_design`,
  `order_design_clustering_new`.`address` AS `address`,
  `order_design_clustering_new`.`address_componentable_id` AS `address_componentable_id`,
  `order_design_clustering_new`.`lat` AS `lat`,
  `order_design_clustering_new`.`lng` AS `lng`,
  `order_design_clustering_new`.`order_date` AS `order_date`,
  `order_design_clustering_new`.`cluster` AS `cluster`,
  `order_design_clustering_new`.`neighbors` AS `neighbors`,
  `order_design_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_design_clustering_new`.`valid_distances` AS `valid_distances`
FROM
  `order_design_clustering_new`
  JOIN address_components_order_design  ON order_design_clustering_new.address_componentable_id = address_components_order_design.address_componentable_id
WHERE
  {{code}}
  AND {{administrative_area_level_1}}
  AND {{administrative_area_level_2}}
  AND {{administrative_area_level_3}}
  AND order_design_clustering_new.order_date >= {{start_date}}
  AND order_design_clustering_new.order_date <= {{end_date}}
  
-- Sales by Code Promo
SELECT 
	`code`,
	COUNT (*) 
FROM 
	`order_design_clustering_new` 
	JOIN address_components_order_design  ON order_design_clustering_new.address_componentable_id = address_components_order_design.address_componentable_id
WHERE
	{{cluster}}
	AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_design_clustering_new.order_date >= {{start_date}}
    AND order_design_clustering_new.order_date <= {{end_date}}
GROUP BY
	`code`;

-- Clustering Location
SELECT
  `order_design_clustering_new`.`id_order_design` AS `id_order_design`,
  `order_design_clustering_new`.`id_user` AS `id_user`,
  `order_design_clustering_new`.`id_designer` AS `id_designer`,
  `order_design_clustering_new`.`code` AS code_promo,
  `order_design_clustering_new`.`status_design` AS `status_design`,
  `order_design_clustering_new`.`address` AS `address`,
  `address_components_order_design`.`administrative_area_level_1`,
  `address_components_order_design`.`administrative_area_level_2`,
  `address_components_order_design`.`administrative_area_level_3`,
  `order_design_clustering_new`.`lat` AS `lat`,
  `order_design_clustering_new`.`lng` AS `lng`,
  `order_design_clustering_new`.`order_date` AS `order_date`,
  `order_design_clustering_new`.`cluster` AS `cluster`,
  `order_design_clustering_new`.`neighbors` AS `neighbors`,
  `order_design_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_design_clustering_new`.`valid_distances` AS `valid_distances`
FROM
  `order_design_clustering_new`
  JOIN address_components_order_design  ON order_design_clustering_new.address_componentable_id = address_components_order_design.address_componentable_id
WHERE
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_design_clustering_new.order_date >= {{start_date}}
    AND order_design_clustering_new.order_date <= {{end_date}}

-- Table Neighbors
SELECT
  `order_design_clustering_new`.`id_order_design` AS `id_order_design`,
  `order_design_clustering_new`.`id_user` AS `id_user`,
  `order_design_clustering_new`.`id_designer` AS `id_designer`,
    `order_design_clustering_new`.`cluster` AS `cluster`,
  `order_design_clustering_new`.`valid_neighbors` AS `valid_neighbors`,
  `order_design_clustering_new`.`valid_distances` AS `valid_distances`,
  `order_design_clustering_new`.`code` AS code_promo,
  `order_design_clustering_new`.`status_design` AS `status_design`,
  `order_design_clustering_new`.`address` AS `address`,
  `address_components_order_design`.`administrative_area_level_1`,
  `address_components_order_design`.`administrative_area_level_2`,
  `address_components_order_design`.`administrative_area_level_3`,
  `order_design_clustering_new`.`lat` AS `lat`,
  `order_design_clustering_new`.`lng` AS `lng`,
  `order_design_clustering_new`.`order_date` AS `order_date`
FROM
  `order_design_clustering_new`
  JOIN address_components_order_design ON order_design_clustering_new.address_componentable_id = address_components_order_design.address_componentable_id
WHERE
    {{cluster}}
    AND {{code}}
    AND {{administrative_area_level_1}}
    AND {{administrative_area_level_2}}
    AND {{administrative_area_level_3}}
    AND order_design_clustering_new.order_date >= {{start_date}}
    AND order_design_clustering_new.order_date <= {{end_date}}


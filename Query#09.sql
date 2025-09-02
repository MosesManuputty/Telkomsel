-- Generalized Query
SELECT 
  a.`report_date`, 
  a.`category`,
  CASE 
    WHEN upper(a.location) IN ('AREA_01', 'AREA_02', 'AREA_03') THEN 'REGION_A'
    WHEN upper(a.location) IN ('AREA_04', 'AREA_05', 'AREA_06') THEN 'REGION_B'
    WHEN upper(a.location) IN ('AREA_07', 'AREA_08', 'AREA_09') THEN 'REGION_C'
    WHEN upper(a.location) IN ('AREA_10', 'AREA_11', 'AREA_12') THEN 'REGION_D'
    ELSE NULL 
  END AS division,
  CASE 
    WHEN upper(a.location) IN ('AREA_01', 'AREA_02') THEN 'SUBREGION_A1'
    WHEN upper(a.location) IN ('AREA_03', 'AREA_04') THEN 'SUBREGION_A2'
    WHEN upper(a.location) IN ('AREA_05', 'AREA_06') THEN 'SUBREGION_B1'
    WHEN upper(a.location) IN ('AREA_07', 'AREA_08') THEN 'SUBREGION_C1'
    ELSE NULL 
  END AS sub_division,
  CASE 
    WHEN upper(a.location) IN ('AREA_01') THEN 'CLUSTER_X'
    WHEN upper(a.location) IN ('AREA_02') THEN 'CLUSTER_Y'
    WHEN upper(a.location) IN ('AREA_03') THEN 'CLUSTER_Z'
    ELSE NULL 
  END AS cluster,
  a.`agent_name`, 
  CAST(SUM(a.`revenue`) AS DECIMAL(20,2)) AS total_revenue
FROM warehouse.`summary_data_202506` a
WHERE a.`product_type` != 'EXCLUDED_TYPE'
  AND a.`sales_region` IN ('REGION_GROUP_1', 'REGION_GROUP_2')
  AND a.location NOT IN (' ', 'UNKNOWN')
GROUP BY 1,2,3,4,5,6
ORDER BY 1;

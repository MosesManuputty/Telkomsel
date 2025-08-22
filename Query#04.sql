SELECT 'Period 1-30 Jun' as period,
a.site_id,
a.network_element_id,
a.cell_identifier,
right(a.cell_identifier, 3) AS sector_identifier,
a.node_type,
a.bandwidth_type,
SUM(a.data_traffic),
SUM(a.content_services),
SUM(a.sms_traffic),
SUM(a.voice_traffic),
SUM(a.total_traffic)
FROM
network_revenue_data_202506 AS a
WHERE a.date BETWEEN '2025-06-01' AND '2025-06-30'
GROUP BY 1,2,3,4,5,6,7
-- 
UNION ALL
-- 
SELECT 'Period 1-30 Jul' as period,
a.site_id,
a.network_element_id,
a.cell_identifier,
right(a.cell_identifier, 3) AS sector_identifier,
a.node_type,
a.bandwidth_type,
SUM(a.data_traffic),
SUM(a.content_services),
SUM(a.sms_traffic),
SUM(a.voice_traffic),
SUM(a.total_traffic)
FROM
network_revenue_data_202507 AS a
WHERE a.date BETWEEN '2025-07-01' AND '2025-07-31'
AND a.region = 'REGION_NAME'
GROUP BY 1,2,3,4,5,6,7;

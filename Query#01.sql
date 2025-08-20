SET @now = '2025-07-31';

SELECT b.kabupaten,

SUM(CASE WHEN event_date = @now THEN data_m12 ELSE 0 END) AS data_all_y1,
SUM(CASE WHEN event_date = @now THEN data_m1 ELSE 0 END) AS data_all_m1,
SUM(CASE WHEN event_date = @now THEN data_mtd ELSE 0 END) AS data_all_m,

SUM(CASE WHEN event_date = @now THEN value_m12 ELSE 0 END) AS value_all_y1,
SUM(CASE WHEN event_date = @now THEN value_m1 ELSE 0 END) AS value_all_m1,
SUM(CASE WHEN event_date = @now THEN value_mtd ELSE 0 END) AS value_all_m,

SUM(CASE WHEN event_date = @now THEN additional_data_m12 ELSE 0 END) AS additional_data_y1,
SUM(CASE WHEN event_date = @now THEN additional_data_m1 ELSE 0 END) AS additional_data_m1,
SUM(CASE WHEN event_date = @now THEN additional_data_mtd ELSE 0 END) AS additional_data_m,

SUM(CASE WHEN event_date = @now THEN digital_data_m12 ELSE 0 END) AS digital_data_y1,
SUM(CASE WHEN event_date = @now THEN digital_data_m1 ELSE 0 END) AS digital_data_m1,
SUM(CASE WHEN event_date = @now THEN digital_data_mtd ELSE 0 END) AS digital_data_m,

SUM(CASE WHEN event_date = @now THEN user_payload_m12 ELSE 0 END) AS user_payload_y1,
SUM(CASE WHEN event_date = @now THEN user_payload_m1 ELSE 0 END) AS user_payload_m1,
SUM(CASE WHEN event_date = @now THEN user_payload_mtd ELSE 0 END) AS user_payload_m

FROM summary_data_table a
RIGHT JOIN region_area_table b
ON a.kabupaten = b.kabupaten
WHERE a.regional = 'PUMA' 
      AND category = 'all'
      AND brand IN('all')
GROUP BY 1
ORDER BY 1;
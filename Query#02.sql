SET @now = '2025-07-31';

SELECT b.kabupaten,
SUM(CASE WHEN tgl = @now THEN revenue_all_m12 ELSE 0 END) AS revenue_all_y1,
SUM(CASE WHEN tgl = @now THEN revenue_all_m1 ELSE 0 END) AS revenue_all_m1,
SUM(CASE WHEN tgl = @now THEN revenue_all_m ELSE 0 END) AS revenue_all_m,

SUM(CASE WHEN tgl = @now THEN revenue_bb_m12 ELSE 0 END) AS revenue_bb_y1,
SUM(CASE WHEN tgl = @now THEN revenue_bb_m1 ELSE 0 END) AS revenue_bb_m1,
SUM(CASE WHEN tgl = @now THEN revenue_bb_m ELSE 0 END) AS revenue_bb_m,

SUM(CASE WHEN tgl = @now THEN revenue_digital_m12 ELSE 0 END) AS revenue_digital_y1,
SUM(CASE WHEN tgl = @now THEN revenue_digital_m1 ELSE 0 END) AS revenue_digital_m1,
SUM(CASE WHEN tgl = @now THEN revenue_digital_m ELSE 0 END) AS revenue_digital_m,

SUM(CASE WHEN tgl = @now THEN revenue_voice_m12 ELSE 0 END) AS revenue_voice_y1,
SUM(CASE WHEN tgl = @now THEN revenue_voice_m1 ELSE 0 END) AS revenue_voice_m1,
SUM(CASE WHEN tgl = @now THEN revenue_voice_m ELSE 0 END) AS revenue_voice_m

FROM summary_revenue_all_kabupaten a
RIGHT JOIN region_area4_2023 b
ON a.kabupaten = b.kabupaten
WHERE a.regional = 'PUMA' AND new_abc_strategy = 'all'
GROUP BY 1
ORDER BY 1;

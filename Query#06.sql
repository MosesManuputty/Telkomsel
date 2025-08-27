SELECT 
    identifier AS code,
    area AS district
FROM `data_table_202503`
WHERE region = 'REGION_X'
GROUP BY 1
-- 
UNION ALL
-- 
SELECT 
    identifier AS code,
    area AS district
FROM `data_table_202504`
WHERE region = 'REGION_X'
GROUP BY 1
-- 
UNION ALL
-- 
SELECT 
    identifier AS code,
    area AS district
FROM `data_table_202505`
WHERE region = 'REGION_X'
GROUP BY 1
-- 
UNION ALL
-- 
SELECT 
    identifier AS code,
    area AS district
FROM `data_table_202506`
WHERE region = 'REGION_X'
GROUP BY 1
-- 
UNION ALL
-- 
SELECT 
    identifier AS code,
    area AS district
FROM `data_table_202507`
WHERE region = 'REGION_X'
GROUP BY 1
-- 
UNION ALL
-- 
SELECT 
    identifier AS code,
    area AS district
FROM `data_table_202508`
WHERE region = 'REGION_X'
GROUP BY 1

WITH data_source_1 AS (
SELECT
    a.identifier AS msisdn,
    a.group AS cluster,
    a.location AS branch,
    a.`STATUS FLAG` AS final_flag,
    a.data_category AS rgb_data
FROM company_data.`source_table_1_20250712` a
),

message_data AS (
SELECT
    a.customer_id AS msisdn,
    a.timestamp AS date
FROM company_data.`channel_data_1_202507` a
--
UNION ALL
--
SELECT
    b.customer_id AS msisdn,
    b.timestamp AS date
FROM company_data.`channel_data_2_202507` b
),

ranked_message_data_begin AS (
SELECT *,
      ROW_NUMBER() OVER (PARTITION BY msisdn ORDER BY date ASC) AS rank_message
    FROM message_data
),

ranked_message_data AS (
SELECT * FROM ranked_message_data_begin
WHERE rank_message = 1
),

purchase_data AS (
SELECT
a.msisdn,
a.package_group,
a.package_subgroup,
a.package_service,
a.package_category,
CAST(a.price AS DECIMAL) AS price,
DAY(purchase_date) AS purchase_day,
ROW_NUMBER() OVER (PARTITION BY msisdn ORDER BY price DESC) AS rank_num
FROM hadoop.`purchase_data_202507` a
WHERE a.price >= 30000
),

ranked_purchase_data AS (
    SELECT *
    FROM purchase_data
    WHERE rank_num=1
),

merged_data AS (
SELECT
    a.msisdn,
    a.cluster,
    a.branch,
    a.final_flag,
    a.rgb_data,
    b.date AS message_date,
    c.purchase_day,
    c.package_group,
    c.package_subgroup,
    c.package_service,
    c.package_category,
    c.price,
    CASE 
        WHEN b.date IS NOT NULL AND c.purchase_day >= b.date THEN c.purchase_day
        ELSE 
            CASE 
                WHEN b.date IS NULL AND c.purchase_day >= 8 THEN c.purchase_day
                ELSE NULL
            END
      END AS transaction_date,
      CASE 
        WHEN a.rgb_data = 'XYZ' AND c.price = 30000 THEN 1000
        WHEN a.rgb_data = 'XYZ' AND c.price = 75000 THEN 1500
        WHEN a.rgb_data = 'XYZ' AND c.price = 100000 THEN 3000
        WHEN a.rgb_data = 'ABC' AND c.price = 30000 THEN 1000
        WHEN a.rgb_data = 'ABC' AND c.price = 75000 THEN 1500
        WHEN a.rgb_data = 'ABC' AND c.price = 100000 THEN 3000
        WHEN a.rgb_data = 'DEF' AND c.price = 30000 THEN 2000
        WHEN a.rgb_data = 'DEF' AND c.price = 75000 THEN 3000
        WHEN a.rgb_data = 'DEF' AND c.price = 100000 THEN 6000
        WHEN a.rgb_data = 'XYZ' AND c.price IS NULL THEN 0
        WHEN a.rgb_data = 'ABC' AND c.price IS NULL THEN 0
        WHEN a.rgb_data = 'DEF' AND c.price IS NULL THEN 0
        ELSE NULL
      END AS incentives
FROM data_source_1 a
LEFT JOIN ranked_message_data b ON a.msisdn = b.msisdn
LEFT JOIN ranked_purchase_data c ON a.msisdn = c.msisdn
ORDER BY c.price DESC
),

final_data AS (
SELECT 
    msisdn,
    cluster,
    branch,
    final_flag,
    rgb_data,
    message_date,
    package_group,
    package_subgroup,
    package_service,
    package_category,
    price,
    transaction_date,
    incentives
FROM merged_data
)

SELECT * FROM final_data
SELECT 
      a.transaction_date AS date,
      a.location_area AS area,
      a.region_name AS region,
      a.city AS city,
      a.department AS department,
      a.service_type AS service,
      SUM(a.subscribers) AS total_subscribers,
      CAST(SUM(a.revenue_amount) AS DECIMAL (20,2)) AS total_revenue
FROM `company_data_202508` a
WHERE transaction_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
GROUP BY 1,2,3,4;
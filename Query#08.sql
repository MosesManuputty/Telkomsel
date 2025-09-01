SELECT 
        a.`report_date`, 
        a.`territory`, 
        a.`product_line`, 
        a.`category`, 
        a.`region`, 
        a.`division`, 
        CAST(SUM(a.`revenue`) AS DECIMAL(20,2)) AS total_revenue
FROM datawarehouse.sales_summary_202507 a
WHERE a.location_code NOT IN ('','TMP')
GROUP BY 1,2,3,4,5,6 
ORDER BY 1;

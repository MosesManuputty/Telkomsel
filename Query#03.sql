SELECT
    a.date,
    a.kabupaten, 
    a.ptoduct_brand 
    a.flag_data 
    a.cust_data, 
    a.cust_Voice_data, 
    a.cust_sms_data,
    a.cust_digital_data,
    a.data_user,
    sum(a.nomor_pelanggan) AS total_pelanggan, 
    sum(a.revenue) AS total_revenue, 
    sum(a.revenue_data) AS total_revenue_data, 
    sum(a.rev_sms) AS total_sms_revenue, 
    sum(a.rev_digital) AS total_digital_revenue, 
    sum(a.rev_voice) AS total_voice_revenue
FROM
    cb_202507 AS a
WHERE 
    a.event_date in ('2024-07-31','2025-06-30','2025-07-31')
GROUP BY 
    1,2,3,4,5,6,7,8,9;
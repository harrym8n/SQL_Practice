SELECT 
  DATE(t1.order_purchase_timestamp) as purchase_date,
  SUM(t1.success) as success,
  (CASE
    WHEN SUM(t1.fail) is NOT NULL THEN SUM(t1.fail)
    WHEN SUM(t1.fail) is NULL THEN 0
  END) as fail
FROM
  (SELECT
    order_purchase_timestamp,
    (CASE WHEN order_estimated_delivery_date >= order_delivered_customer_date THEN 1 END) as success,
    (CASE WHEN order_estimated_delivery_date < order_delivered_customer_date THEN 1 END) as fail
  FROM
    olist_orders_dataset
  WHERE
    order_delivered_customer_date IS NOT NULL AND
    order_estimated_delivery_date IS NOT NULL AND
    order_purchase_timestamp LIKE '2017-01%') t1
GROUP BY
  DATE(t1.order_purchase_timestamp)
ORDER BY
  purchase_date
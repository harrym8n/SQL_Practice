SELECT
  DATE(t1.order_purchase_timestamp) as dt,
  ROUND(SUM(t2.payment_value),2) as revenue_daily
FROM
  olist_orders_dataset t1,
  olist_order_payments_dataset t2
WHERE
  t1.order_id = t2.order_id AND
  DATE(t1.order_purchase_timestamp) >= '2018-01-01'
GROUP BY
  DATE(t1.order_purchase_timestamp)
ORDER BY
  dt
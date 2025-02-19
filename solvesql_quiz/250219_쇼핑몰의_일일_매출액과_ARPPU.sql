-- 2018년 1월 1일 이후 일별로 집계된 쇼핑몰의 결제 고객 수, 매출액, ARPPU를 계산

SELECT
  DATE(t1.order_purchase_timestamp) as dt,
  COUNT(DISTINCT t1.customer_id) as pu,
  ROUND(SUM(t2.payment_value), 2) as revenue_daily,
  ROUND((SUM(t2.payment_value) / COUNT(DISTINCT t1.customer_id)), 2) as arppu
FROM
  olist_orders_dataset t1,
  olist_order_payments_dataset t2
WHERE
  t1.order_id = t2.order_id AND
  DATE(t1.order_purchase_timestamp) >= '2018-01-01'
GROUP BY
  DATE(t1.order_purchase_timestamp)
ORDER BY
  DATE(t1.order_purchase_timestamp)
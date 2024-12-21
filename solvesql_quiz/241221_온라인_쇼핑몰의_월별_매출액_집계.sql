WITH canceled_t as
(
SELECT
  strftime('%Y-%m', t1.order_date) as order_month,
  SUM(t2.price*t2.quantity) as canceled_amount
FROM orders t1, order_items t2
WHERE t1.order_id = t2.order_id AND
      t1.order_id LIKE 'C%'
GROUP BY  strftime('%Y-%m', t1.order_date)
),
ordered_t as (
SELECT
  strftime('%Y-%m', t1.order_date) as order_month,
  SUM(t2.price*t2.quantity) as ordered_amount
FROM orders t1, order_items t2
WHERE t1.order_id = t2.order_id AND
      t1.order_id NOT LIKE 'C%'
GROUP BY  strftime('%Y-%m', t1.order_date)
),
total_t as (
SELECT
  strftime('%Y-%m', t1.order_date) as order_month,
  SUM(t2.price*t2.quantity) as total_amount
FROM orders t1, order_items t2
WHERE t1.order_id = t2.order_id
GROUP BY  strftime('%Y-%m', t1.order_date)
)

SELECT t1.order_month, t1.ordered_amount, t2.canceled_amount, t3.total_amount
FROM ordered_t t1 
LEFT JOIN canceled_t t2 ON t1.order_month = t2.order_month
LEFT JOIN total_t t3 ON t1.order_month = t3.order_month
ORDER BY t1.order_month
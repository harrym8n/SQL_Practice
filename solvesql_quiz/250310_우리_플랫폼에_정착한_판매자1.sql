SELECT
  seller_id,
  COUNT(DISTINCT order_id) as orders
FROM
  olist_order_items_dataset
GROUP BY
  seller_id
HAVING
  COUNT(DISTINCT order_id) >= 100
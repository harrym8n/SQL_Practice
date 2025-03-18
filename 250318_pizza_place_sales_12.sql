WITH CTE AS
(
	SELECT
		*,
		RANK() OVER(PARTITION BY DATE_FORMAT(t11.date, '%m') ORDER BY t11.total_quantity DESC) AS rnk
	FROM
		(SELECT t1.date, SUM(t2.quantity) AS total_quantity
		FROM orders t1, order_details t2
		WHERE t1.order_id = t2.order_id
		GROUP BY t1.date) t11
)

SELECT date, total_quantity
FROM CTE
WHERE rnk = 1
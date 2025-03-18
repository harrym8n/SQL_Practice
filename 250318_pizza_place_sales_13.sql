WITH CTE AS(
	SELECT
		t1.*,
		ROUND(
			PERCENT_RANK()
			OVER(ORDER BY t1.total_quantity DESC)
		,2) AS percent_rnk
	FROM
		(SELECT pizza_id, SUM(quantity) AS total_quantity
		FROM order_details
		GROUP BY pizza_id) t1
)

SELECT total_quantity
FROM CTE	
WHERE percent_rnk <= 0.1
ORDER BY total_quantity ASC LIMIT 1
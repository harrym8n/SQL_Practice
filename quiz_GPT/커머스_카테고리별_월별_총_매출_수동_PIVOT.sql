-- chatGPT 출제
-- 2024년 한 해 동안 completed 상태의 주문을 기준으로,
-- 각 카테고리별로 월별 총 매출을 수동 PIVOT 형태로 출력

SELECT
	p.category,
	SUM(CASE WHEN MONTH(o.order_date) = 1 THEN oi.quantity * oi.price ELSE 0 END) AS 'jan_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 2 THEN oi.quantity * oi.price ELSE 0 END) AS 'feb_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 3 THEN oi.quantity * oi.price ELSE 0 END) AS 'mar_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 4 THEN oi.quantity * oi.price ELSE 0 END) AS 'apr_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 5 THEN oi.quantity * oi.price ELSE 0 END) AS 'may_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 6 THEN oi.quantity * oi.price ELSE 0 END) AS 'jun_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 7 THEN oi.quantity * oi.price ELSE 0 END) AS 'jul_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 8 THEN oi.quantity * oi.price ELSE 0 END) AS 'aug_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 9 THEN oi.quantity * oi.price ELSE 0 END) AS 'sep_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 10 THEN oi.quantity * oi.price ELSE 0 END) AS 'oct_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 11 THEN oi.quantity * oi.price ELSE 0 END) AS 'nov_sales',
	SUM(CASE WHEN MONTH(o.order_date) = 12 THEN oi.quantity * oi.price ELSE 0 END) AS 'dec_sales'
FROM
	orders o
	LEFT JOIN order_items oi ON o.order_id = oi.order_id
	LEFT JOIN products p ON oi.product_id = p.product_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status = 'completed'
GROUP BY 
	p.category
-- 이커머스 플랫폼에서 고객 이탈 여부를 판단하기 위해, 다음 기준에 따라 ‘휴면 고객’의 수를 구하세요.
-- 2024년 이전에 최소 1회 status = 'completed' 주문을 한 이력이 있는 고객 중에서,
-- 2024년 한 해 동안에는 한 번도 status = 'completed' 주문을 하지 않은 고객을 이탈 고객(휴면 고객)으로 간주

WITH data_before_2024 AS
(
	SELECT DISTINCT o.customer_id
	FROM orders o
	WHERE YEAR(o.order_date) < 2024 AND o.status = 'completed'
), data_after_2024 AS
(
	SELECT DISTINCT o.customer_id
	FROM orders o
	WHERE YEAR(o.order_date) = 2024 AND o.status = 'completed'
)

SELECT COUNT(*) AS dormant_customer_count
FROM data_before_2024 db
LEFT JOIN data_after_2024 da ON db.customer_id = da.customer_id
WHERE da.customer_id IS NULL
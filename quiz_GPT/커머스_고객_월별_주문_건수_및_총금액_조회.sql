-- chatGPT 출제
-- 2025년 3월부터 5월까지 월별로 완료된(status = 'completed') 주문에 대해 다음을 구하세요:
-- 각 월(YYYY-MM)별 주문 수 (order_count)
-- 각 월별 총 결제 금액(quantity * price의 합계)
-- 결과는 월 기준 오름차순 정렬
-- 월 단위 그룹핑 (예: 2025-03, 2025-04, 2025-05)
-- 출력 컬럼: order_month, order_count, total_payment

WITH CTE AS 
(
SELECT 
	DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
	o.order_id,
	(quantity * price) AS payment
FROM
	orders o 
	JOIN oredr_items oi ON o.order_id = oi.order_id
WHERE
	o.status = 'completed' AND
	(DATE_FORMAT(o.order_date, '%Y-%m-%d') BETWEEN '2025-03-01' AND '2025-05-31')
)

SELECT order_month, COUNT(DISTINCT order_id) AS order_count, SUM(payment) AS total_payment
FROM CTE
GROUP BY order_month
ORDER BY order_month
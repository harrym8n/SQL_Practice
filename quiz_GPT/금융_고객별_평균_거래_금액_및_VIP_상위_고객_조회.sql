-- chatGPT
-- 최근 6개월 동안(2024-12-01~2025-05-31)의 거래 데이터를 기준으로,
-- 고객별로 입금(deposit) 거래의 평균 금액을 계산하고,
-- 평균 금액이 1,000,000원 이상인 고객 중에서
-- 상위 5명의 고객 이름과 평균 입금 금액을 조회하세요.

SELECT
	c.name,
	AVG(t.amount) AS avg_deposit_amount
FROM
	transactions t
	JOIN customers c ON t.customer_id = c.customer_id
WHERE
	(DATE_FORMAT(t.transaction_date, '%Y-%m-%d') BETWEEN '2024-12-01' AND '2025-05-31') AND
	t.transaction_type = 'deposit'
GROUP BY
	t.customer_id,
	c.name
HAVING
	AVG(t.amount) >= 1000000
ORDER BY
	AVG(t.amount) DESC LIMIT 5
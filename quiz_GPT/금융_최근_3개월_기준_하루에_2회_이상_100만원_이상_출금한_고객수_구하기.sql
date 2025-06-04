-- chatGPT 출제
-- 최근 3개월(2025년 3월 1일~5월 31일) 동안 동일한 날에 2번 이상 100만원 이상의 출금(withdrawal)을 수행한 고객을 탐지
-- 해당 조건을 만족한 고객 수 (중복 없이) 출력

WITH CTE AS 
(
SELECT
	customer_id
FROM 
	transactions
WHERE
	(DATE_FORMAT(transaction_date, '%Y-%m-%d') BETWEEN '2025-03-01' AND '2025-05-31') AND
	transaction_type = 'withdrawal' AND
	amount >= 1000000
GROUP BY
	customer_id, (DATE_FORMAT(transaction_date, '%Y-%m-%d')
HAVING 
	COUNT(DISTINCT transaction_id) >= 2
)

SELECT COUNT(DISTINCT customer_id) AS suspicious_customer_count
FROM CTE
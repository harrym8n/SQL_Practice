-- chatGPT 출제
-- 실명 인증 포함 송금 퍼널 분석

WITH base AS 
(
SELECT
	user_id,
	MAX(CASE WHEN event_type = 'send_money_try' THEN 1 ELSE 0 END) AS send_money_try,
	MAX(CASE WHEN event_type = 'verify_identity' THEN 1 ELSE 0 END) AS verify_identity,
	MAX(CASE WHEN event_type = 'send_money_complete' THEN 1 ELSE 0 END) AS send_money_complete
FROM
	event_logs
WHERE
	event_time BETWEEN '2025-06-01' AND '2025-06-30'
GROUP BY
	user_id
), first_total AS
(
SELECT SUM(send_money_try) AS cnt
FROM base
WHERE send_money_try = 1
), second_total AS
(
SELECT SUM(verify_identity) AS cnt
FROM base
WHERE send_money_try = 1 AND verify_identity = 1
)

SELECT
	'send_money_try' AS step,
	SUM(send_money_try) AS user_count,
	ROUND(100.0,2) AS conversion_rate
FROM base
	
UNION ALL

SELECT
	'verify_identity' AS step,
	SUM(verify_identity) AS user_count,
	ROUND((SUM(verify_identity)/(SELECT cnt FROM first_total))*100,2) AS conversion_rate
FROM base

UNION ALL

SELECT
	'send_money_complete' AS step,
	SUM(send_money_complete) AS user_count,
	ROUND((SUM(send_money_complete)/(SELECT cnt FROM second_total))*100,2) AS conversion_rate
FROM base
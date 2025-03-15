-- 각 날짜별 총 주문 건수를 계산
-- 하루 총 주문 건수가 80건 이상인 날짜만 조회
-- 주문 건수가 많은 순서대로 정렬

SELECT date, COUNT(DISTINCT order_id) as order_cnt
FROM orders
GROUP BY date
HAVING order_cnt >= 80
ORDER BY order_cnt DESC
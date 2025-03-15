-- 피자별 총 주문 수량이 10개 이상인 피자만 조회
-- 총 주문 수량 기준으로 내림차순 정렬

SELECT pizza_id, SUM(quantity) AS sum_quantity
FROM order_details
GROUP BY pizza_id
HAVING sum_quantity >= 10
ORDER BY sum_quantity DESC
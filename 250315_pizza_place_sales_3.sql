-- 각 피자 카테고리별 피자 종류의 개수를 계산
-- 피자 종류가 3개 이상인 카테고리만 조회
-- 피자 종류 개수 기준으로 오름차순 정렬

SELECT category, COUNT(pizza_type_id) AS pizza_cnt
FROM pizza_types
GROUP BY category
HAVING pizza_cnt >= 3
ORDER BY pizza_cnt
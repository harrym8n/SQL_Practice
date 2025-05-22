-- GPT 제작문제
-- 가장 많이 구매된 게임 TOP 3
-- 구매 이력을 바탕으로 가장 많이 판매된 게임 상위 3개의 게임명과 판매 수량을 출력하시오.
SELECT 
    g.name AS game_name,
    COUNT(*) AS purchase_count
FROM purchases p
JOIN games g ON p.game_id = g.game_id
GROUP BY g.game_id, g.name
ORDER BY purchase_count DESC
LIMIT 3
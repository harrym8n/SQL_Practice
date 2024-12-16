# 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회
# 결과는 시간대 순으로 정렬
WITH RECURSIVE numbers AS (
    SELECT 0 AS HOUR
    UNION ALL
    SELECT HOUR + 1
    FROM numbers
    WHERE HOUR < 23
)

SELECT t1.HOUR, IFNULL(t2.COUNT,0) as COUNT
FROM numbers t1 LEFT JOIN (SELECT HOUR(DATETIME) as HOUR , COUNT(*) as COUNT
                           FROM ANIMAL_OUTS
                           GROUP BY HOUR(DATETIME)
                           ORDER BY HOUR) t2
ON t1.HOUR = t2.HOUR
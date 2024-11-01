# 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려함
# 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회
# 결과는 시간대 순으로 정렬

SELECT DATE_FORMAT(DATETIME, '%H') as HOUR, COUNT(ANIMAL_ID) as COUNT
FROM ANIMAL_OUTS
WHERE DATE_FORMAT(DATETIME, '%H') BETWEEN 9 AND 19
GROUP BY DATE_FORMAT(DATETIME, '%H')
ORDER BY HOUR
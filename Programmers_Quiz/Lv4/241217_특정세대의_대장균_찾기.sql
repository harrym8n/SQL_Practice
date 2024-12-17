# 3세대의 대장균의 ID(ID) 를 출력

SELECT t1.ID
FROM ECOLI_DATA t1 LEFT JOIN ECOLI_DATA t2
ON t1.PARENT_ID = t2.ID
WHERE t2.PARENT_ID IN (SELECT DISTINCT t1.PARENT_ID as PARENT_ID
                       FROM ECOLI_DATA t1 LEFT JOIN ECOLI_DATA t2
                       ON t1.PARENT_ID = t2.ID
                       WHERE t1.PARENT_ID IS NOT NULL AND
                       t2.PARENT_ID IS NULL)
ORDER BY t1.ID
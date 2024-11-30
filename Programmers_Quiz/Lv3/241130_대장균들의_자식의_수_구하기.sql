# 대장균 개체의 ID(ID)와 자식의 수(CHILD_COUNT)를 출력
# 자식이 없다면 자식의 수는 0으로 출력
# 결과는 개체의 ID 에 대해 오름차순 정렬

SELECT t1.ID, IFNULL(t2.CHILD_COUNT,0) as CHILD_COUNT
FROM ECOLI_DATA t1
LEFT JOIN (SELECT IFNULL(PARENT_ID,0) as ID, COUNT(*) as CHILD_COUNT
                     FROM ECOLI_DATA
                     GROUP BY PARENT_ID) t2 ON t1.ID = t2.ID
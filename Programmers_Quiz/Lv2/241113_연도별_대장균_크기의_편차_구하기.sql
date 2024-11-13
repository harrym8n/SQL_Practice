# 분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID) 를 출력
# 분화된 연도별 대장균 크기의 편차는 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기로 구하며 
# 결과는 연도에 대해 오름차순으로 정렬, 같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬

SELECT t1.YEAR, (t2.MAX_SIZE - t1.SIZE_OF_COLONY) as YEAR_DEV, t1.ID
FROM 
    (SELECT YEAR(DIFFERENTIATION_DATE) as YEAR, SIZE_OF_COLONY, ID
    FROM ECOLI_DATA) t1,
    (SELECT YEAR(DIFFERENTIATION_DATE) as YEAR, MAX(SIZE_OF_COLONY) as MAX_SIZE
    FROM ECOLI_DATA
    GROUP BY YEAR(DIFFERENTIATION_DATE)) t2
WHERE t1.YEAR = t2.YEAR
ORDER BY t1.YEAR, YEAR_DEV
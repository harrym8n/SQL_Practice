# 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회
# 결과는 보호 시작일 순으로 조회

SELECT ai.NAME, ai.DATETIME
FROM ANIMAL_INS ai 
    LEFT JOIN ANIMAL_OUTS ao 
    ON ai.ANIMAL_ID = ao.ANIMAL_ID
WHERE ao.ANIMAL_ID is NULL
ORDER BY ai.DATETIME ASC LIMIT 3
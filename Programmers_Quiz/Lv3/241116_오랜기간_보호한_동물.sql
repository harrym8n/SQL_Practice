# 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회
# 결과는 보호 기간이 긴 순으로 조회
SELECT ai.ANIMAL_ID, ai.NAME
FROM ANIMAL_INS ai, ANIMAL_OUTS ao
WHERE ai.ANIMAL_ID = ao.ANIMAL_ID
ORDER BY DATEDIFF(ao.DATETIME, ai.DATETIME) DESC LIMIT 2
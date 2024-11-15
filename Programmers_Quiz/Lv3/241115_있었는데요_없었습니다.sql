# 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회
# 결과는 보호 시작일이 빠른 순으로 조회

SELECT ai.ANIMAL_ID, ai.NAME
FROM ANIMAL_INS ai, ANIMAL_OUTS ao
WHERE ai.ANIMAL_ID = ao.ANIMAL_ID and ai.DATETIME > ao.DATETIME
ORDER BY ai.DATETIME asc

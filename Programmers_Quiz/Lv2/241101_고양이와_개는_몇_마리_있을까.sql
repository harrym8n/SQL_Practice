# 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회
# 고양이를 개보다 먼저 조회

SELECT ANIMAL_TYPE, COUNT(*) as count
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
HAVING ANIMAL_TYPE IN ('Cat', 'Dog')
ORDER BY FIELD(ANIMAL_TYPE, 'Cat', 'Dog')
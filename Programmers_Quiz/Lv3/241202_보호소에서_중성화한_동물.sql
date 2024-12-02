# 보호소에 들어올 당시에는 중성화되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성

SELECT ao.ANIMAL_ID, ao.ANIMAL_TYPE, ao.NAME
FROM ANIMAL_INS ai, ANIMAL_OUTS ao
WHERE ai.ANIMAL_ID = ao.ANIMAL_ID AND
    ai.SEX_UPON_INTAKE LIKE "Intact%" AND
    ao.SEX_UPON_OUTCOME NOT LIKE "Intact%"
ORDER BY ao.ANIMAL_ID
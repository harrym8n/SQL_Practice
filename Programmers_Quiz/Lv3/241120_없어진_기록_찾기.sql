# 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회

SELECT ao.ANIMAL_ID, ao.NAME
FROM ANIMAL_INS ai
    RIGHT OUTER JOIN ANIMAL_OUTS ao
    ON ai.ANIMAL_ID = ao.ANIMAL_ID
WHERE ao.ANIMAL_ID is NOT NULL AND
      ai.ANIMAL_ID is NULL
ORDER BY ao.ANIMAL_ID
#programmers Lv2 문제 - 동명 동물 수 찾기(Finding the number of animals of the same name)

SELECT NAME, COUNT(NAME) as COUNT
FROM ANIMAL_INS
GROUP BY name
HAVING COUNT >= 2
ORDER BY NAME

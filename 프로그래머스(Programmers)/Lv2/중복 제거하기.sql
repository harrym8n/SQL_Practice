#To dedupe
SELECT COUNT(distinct name) as COUNT
FROM ANIMAL_INS
WHERE name is not NULL

#Find an animal with an 'el' in its name
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS as AI
WHERE NAME LIKE '%el%' and ANIMAL_TYPE = 'Dog'
ORDER BY NAME

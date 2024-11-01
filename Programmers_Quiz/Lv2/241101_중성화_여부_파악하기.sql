#보호소의 동물이 중성화되었는지 아닌지 파악
#중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어 포함
#동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회
#이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시

SELECT ANIMAL_ID, NAME, 
    CASE 
        WHEN SEX_UPON_INTAKE LIKE '%Neutered%' THEN 'O'
        WHEN SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
        ELSE 'X' END
FROM ANIMAL_INS
ORDER BY ANIMAL_ID
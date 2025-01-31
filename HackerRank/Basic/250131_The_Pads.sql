-- 풀이1. 테이블 병합하여 한번에 출력
SELECT col 
FROM (
    SELECT CONCAT(NAME, '(', LEFT(Occupation,1), ')') AS col, 
           1 AS sort_order, 
           NAME AS sort_value, 
           NULL AS cnt, 
           NULL AS occ
    FROM OCCUPATIONS

    UNION ALL

    SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.') AS col, 
           2 AS sort_order, 
           NULL AS sort_value, 
           COUNT(*) AS cnt, 
           Occupation AS occ
    FROM OCCUPATIONS
    GROUP BY Occupation
) AS combined_result
ORDER BY sort_order, cnt, occ, sort_value;


-- 풀이2. 테이블 병합하지 않고 각자 출력
SELECT Name, CONCAT(NAME,'(',LEFT(Occupation,1),')') as col
FROM OCCUPATIONS
ORDER BY col;

SELECT CONCAT('There are a total of ',COUNT(*),' ', LOWER(Occupation),'s.') as col
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;
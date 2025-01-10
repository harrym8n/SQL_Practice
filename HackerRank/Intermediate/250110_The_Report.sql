-- Name, Grade and Mark
-- the NAMES of those students who received a grade lower than 8 > Null
-- grade >= 8 : order in descending order by grades, if same grade name ASC
-- grade < 8 : order in descending order by grades, if same grade Marks ASC

SELECT 
  CASE WHEN t1.Grade >= 8 THEN t1.Name
       WHEN t1.Grade < 8 THEN NULL
  END as Name,
  t1.Grade,
  t1.Marks
FROM
  (SELECT
    Name, Marks,
    CASE WHEN Marks BETWEEN 0 AND 9 THEN 1
         WHEN Marks BETWEEN 10 AND 19 THEN 2
         WHEN Marks BETWEEN 20 AND 29 THEN 3
         WHEN Marks BETWEEN 30 AND 39 THEN 4
         WHEN Marks BETWEEN 40 AND 49 THEN 5
         WHEN Marks BETWEEN 50 AND 59 THEN 6
         WHEN Marks BETWEEN 60 AND 69 THEN 7
         WHEN Marks BETWEEN 70 AND 79 THEN 8
         WHEN Marks BETWEEN 80 AND 89 THEN 9
         WHEN Marks BETWEEN 90 AND 100 THEN 10
      END as Grade
  FROM
    Students) t1
ORDER BY
  t1.grade DESC, t1.Name ASC, t1.Marks ASC
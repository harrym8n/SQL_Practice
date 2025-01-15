-- output the names of those students whose best friends got offered a higher salary than them
-- Names must be ordered by the salary amount offered to the best friends
-- It is guaranteed that no two students got same salary offer

SELECT 
  t1.name
FROM
  (SELECT t1.ID, t1.name, t2.Friend_ID , t3.Salary
  FROM
    Students t1,
    Friends t2,
    Packages t3
  WHERE
    t1.ID = t2.ID AND
    t1.ID = t3.ID) t1,
  (SELECT t1.ID, t2.Salary
   FROM
    Students t1,
    Packages t2
  WHERE
    t1.ID = t2.ID) t2
WHERE
  t1.Friend_ID = t2.ID AND
  t1.Salary < t2.Salary
ORDER BY
  t2.Salary
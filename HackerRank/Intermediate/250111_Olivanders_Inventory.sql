-- print the id, age, coins_needed, and power of the wands that Ron's interested in
-- determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age.
-- sorted in order of descending power
-- if same power > sort the result in order of descending age

SELECT
  t1.id,
  t2.age, t2.gold, t2.power
FROM 
  (SELECT
    t1.id, t1.power, t2.age, t1.coins_needed
  FROM
    Wands t1,
    Wands_Property t2
  WHERE
    t1.code = t2.code AND
    t2.is_evil = 0) t1,
  (SELECT
    t1.power, t2.age, MIN(t1.coins_needed) as gold
   FROM
    Wands t1,
    Wands_Property t2
   WHERE
    t1.code = t2.code AND
    t2.is_evil = 0
   GROUP BY
    t1.power, 
    t2.age
   ORDER BY
    t1.power DESC,
    t2.age DESC) t2
WHERE
  t1.power = t2.power AND
  t1.age = t2.age AND
  t1.coins_needed = t2.gold
ORDER BY
  t2.power DESC,
  t2.age DESC
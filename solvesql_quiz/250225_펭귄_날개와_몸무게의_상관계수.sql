--  날개 길이와 몸무게의 피어슨 상관 계수(Pearson Correlation Coefficient)를 구하는 쿼리

WITH avg_t AS(
  SELECT 
    species,
    AVG(flipper_length_mm) as avg_length,
    AVG(body_mass_g) as avg_mass
  FROM
    penguins
  GROUP BY
    species
)


SELECT
  t1.species,
  ROUND((SUM((t1.flipper_length_mm - t2.avg_length)*(t1.body_mass_g-t2.avg_mass)))/
    (SQRT(SUM(POWER((t1.flipper_length_mm - t2.avg_length),2)))*SQRT(SUM(POWER((t1.body_mass_g - t2.avg_mass),2)))),3) as corr
FROM
  penguins t1,
  avg_t t2
WHERE
  t1.species = t2.species
GROUP BY
  t1.species
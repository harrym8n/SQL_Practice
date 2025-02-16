SELECT
  t1.season,
  MEDIAN(t1.pm10) as pm10_median,
  ROUND(AVG(t1.pm10),2) as pm10_average
FROM
  (SELECT
    CASE
      WHEN measured_at BETWEEN '2022-03-01' AND '2022-05-31' THEN 'spring'
      WHEN measured_at BETWEEN '2022-06-01' AND '2022-08-31' THEN 'summer'
      WHEN measured_at BETWEEN '2022-09-01' AND '2022-11-30' THEN 'autumn'
      ELSE 'winter'
    END as season,
    pm10
  FROM
    measurements) t1
GROUP BY
  t1.season
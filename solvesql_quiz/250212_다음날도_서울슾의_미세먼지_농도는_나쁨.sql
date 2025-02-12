SELECT
  t1.measured_at as today,
  t2.measured_at as next_day,
  t1.pm10,
  t2.pm10 as next_pm10
FROM
  measurements t1,
  measurements t2    
WHERE
  DATE(datetime(t1.measured_at, '+1 days')) = t2.measured_at AND
  t1.pm10 < t2.pm10
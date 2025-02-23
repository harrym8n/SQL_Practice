-- 2018년 데이터 테이블 생성
WITH t_2018 AS(
SELECT
  t1.station_id, t1.name, t1.local,
  CASE
    WHEN (COALESCE(t2.rent_count, 0) + COALESCE(t3.return_count, 0)) IS NULL THEN 0
    ELSE (COALESCE(t2.rent_count, 0) + COALESCE(t3.return_count, 0)) 
  END as 'count_18'
FROM
  station t1
LEFT OUTER JOIN
  (SELECT rent_station_id, COUNT(*) as rent_count
  FROM rental_history
  WHERE rent_at BETWEEN '2018-10-01 00:00:00' AND '2018-10-31 23:59:59'
  GROUP BY rent_station_id) t2 ON t1.station_id = t2.rent_station_id
LEFT OUTER JOIN
  (SELECT return_station_id, COUNT(*) as return_count
  FROM rental_history
  WHERE return_at BETWEEN '2018-10-01 00:00:00' AND '2018-10-31 23:59:59'
  GROUP BY return_station_id) t3 ON t1.station_id = t3.return_station_id
GROUP BY
  t1.station_id),


-- 2018년 데이터 테이블 생성
t_2019 AS(
SELECT
  t1.station_id, t1.name, t1.local,
  CASE
    WHEN (COALESCE(t2.rent_count, 0) + COALESCE(t3.return_count, 0)) IS NULL THEN 0
    ELSE (COALESCE(t2.rent_count, 0) + COALESCE(t3.return_count, 0)) 
  END as 'count_19'
FROM
  station t1
LEFT OUTER JOIN
  (SELECT rent_station_id, COUNT(*) as rent_count
  FROM rental_history
  WHERE rent_at BETWEEN '2019-10-01 00:00:00' AND '2019-10-31 23:59:59'
  GROUP BY rent_station_id) t2 ON t1.station_id = t2.rent_station_id
LEFT OUTER JOIN
  (SELECT return_station_id, COUNT(*) as return_count
  FROM rental_history
  WHERE return_at BETWEEN '2019-10-01 00:00:00' AND '2019-10-31 23:59:59'
  GROUP BY return_station_id) t3 ON t1.station_id = t3.return_station_id
GROUP BY
  t1.station_id)


-- 최종 데이터 조회 쿼리
SELECT
  t1.station_id,
  t1.name,
  t1.local,
  ROUND(((t2.count_19+0.00)/t1.count_18)*100,2) as usage_pct
FROM
 t_2018 t1,
 t_2019 t2
WHERE
  t1.station_id = t2.station_id AND
  t1.count_18 != 0 AND 
  t2.count_19 != 0 AND
  ((t2.count_19+0.00)/t1.count_18) <= 0.5
SELECT
  DISTINCT t2.athlete_id
FROM
  events t1,
  records t2
WHERE
  t2.event_id = t1.id AND
  t1.sport = 'Golf'
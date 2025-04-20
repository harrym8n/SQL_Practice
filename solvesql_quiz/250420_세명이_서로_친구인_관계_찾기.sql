SELECT
  t1.user_a_id AS user_a_id, t2.user_a_id AS user_b_id, t2.user_b_id AS user_c_id
FROM edges t1
JOIN edges t2 ON t1.user_b_id = t2.user_a_id
JOIN edges t3 ON t1.user_a_id = t3.user_a_id AND t2.user_b_id = t3.user_b_id
WHERE
  t1.user_a_id = 3820 OR
  t2.user_a_id = 3820 OR
  t2.user_b_id = 3820 AND
  t1.user_a_id < t2.user_a_id < t2.user_b_id
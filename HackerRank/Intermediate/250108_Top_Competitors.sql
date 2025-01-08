-- print the respective hacker_id and name of hackers who achieved full scores for more than one challeng
-- descending order by the total number of challenges in which the hacker earned a full score
-- if more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id

SELECT 
  t1.hacker_id,
  t1.name
FROM
  Hackers t1,
  (SELECT
    t1.hacker_id, COUNT(*) as count_v
  FROM 
    (
    SELECT
      t1.hacker_id, t1.challenge_id, t1.score, t3.score as full_score
    FROM
      Submissions t1,
      Challenges t2,
      Difficulty t3
    WHERE
      t1.challenge_id = t2.challenge_id AND
      t2.difficulty_level = t3.difficulty_level
    ) t1
  WHERE
    t1.score = t1.full_score
  GROUP BY
    t1.hacker_id) t2
WHERE
  t1.hacker_id = t2.hacker_id AND
  t2.count_v > 1
ORDER BY 
  t2.count_v DESC,
  t1.hacker_id
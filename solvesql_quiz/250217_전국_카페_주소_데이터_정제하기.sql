SELECT
  substr(address, 1, instr(address, ' ') - 1) AS sido,
  substr(substr(address, instr(address, ' ') +1), 1, instr(substr(address, instr(address, ' ') +1),' ') - 1) AS sigungu,
  COUNT(cafe_id) as cnt
FROM
  cafes
GROUP BY
  substr(address, 1, instr(address, ' ') - 1),
  substr(substr(address, instr(address, ' ') +1), 1, instr(substr(address, instr(address, ' ') +1),' ') - 1)
ORDER BY
  cnt DESC
-- 2번 형질이 보유하지 않으면서 1번이나 3번 형질을 보유하고 있는 대장균 개체의 수 출력

SELECT COUNT(*) AS COUNT
FROM ECOLI_DATA
WHERE genotype & 5 in (1,4,5) AND
      genotype & 2 NOT in (2)
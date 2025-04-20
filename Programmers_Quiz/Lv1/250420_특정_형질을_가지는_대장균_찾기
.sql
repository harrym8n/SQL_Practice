SELECT COUNT(*) AS COUNT
FROM ECOLI_DATA
WHERE genotype & 5 in (1,4,5) AND
      genotype & 2 NOT in (2)
SELECT ROUND(avg(length_2),2) as AVERAGE_LENGTH
FROM(
    SELECT length,
        CASE
            WHEN (length is null) THEN 10
            ELSE length
        END as 'length_2'
    FROM fish_info) fish_info_new
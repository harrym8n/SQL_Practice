SELECT
    ROUND(SUM(LAT_N),2) as sum_lat_n,
    ROUND(SUM(LONG_W),2) as sum_long_w
FROM
    STATION
    
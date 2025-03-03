SELECT day, ROUND(SUM(tip),2) as tip_daily
FROM tips
GROUP BY day
ORDER BY tip_daily DESC LIMIT 1
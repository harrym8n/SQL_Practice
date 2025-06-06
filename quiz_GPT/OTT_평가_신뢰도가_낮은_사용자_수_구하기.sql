WITH view_ratio AS (
    SELECT
        wl.user_id,
        wl.content_id,
        ROUND(SUM(wl.watch_time) / c.duration, 2) AS watch_ratio
    FROM
        watch_logs wl
    JOIN content c ON wl.content_id = c.content_id
    WHERE
        YEAR(wl.watch_date) = 2024
    GROUP BY
        wl.user_id, wl.content_id, c.duration
),

user_watch_avg AS (
    SELECT
        user_id,
        AVG(watch_ratio) AS avg_watch_ratio
    FROM
        view_ratio
    GROUP BY
        user_id
),

user_rating_avg AS (
    SELECT
        user_id,
        AVG(rating) AS avg_rating
    FROM
        ratings
    WHERE
        YEAR(rating_date) = 2024
    GROUP BY
        user_id
)

SELECT
    COUNT(*) AS unreliable_user_count
FROM
    user_watch_avg uwa
JOIN user_rating_avg ura ON uwa.user_id = ura.user_id
WHERE
    uwa.avg_watch_ratio < 0.3
    AND ura.avg_rating >= 4.5
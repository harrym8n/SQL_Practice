SELECT
  quartet,
  ROUND(AVG(x),2) as x_mean,
  ROUND(VAR_SAMP(x),2) as x_var,
  ROUND(AVG(y),2) as y_mean,
  ROUND(VAR_SAMP(y),2) as y_var
FROM
  points
GROUP BY
  quartet
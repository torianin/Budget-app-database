WITH x AS (
SELECT
 users.id, value, period
FROM
 users
 JOIN transactions ON transactions.user_id = users.id
 JOIN recurring_infos ON transactions.recurring_info_id = recurring_infos.id
 JOIN prices ON transactions.id = prices.transaction_id
 JOIN currencies ON prices.currency_id = currencies.id
 
WHERE
 transaction_type = 'income'
 AND currencies.short_name = 'USD'
 )
SELECT
  x.id as user_id,
  
  sum (CASE x.period
    WHEN 'daily' THEN x.value
    WHEN 'weekly' THEN x.value / 7
    WHEN 'monthly' THEN x.value / 30
    ELSE 0
  END * 365 * 20) as income20years
FROM
  x
GROUP BY x.id
ORDER BY income20years DESC
LIMIT 1

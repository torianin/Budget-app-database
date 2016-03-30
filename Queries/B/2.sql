SELECT
  transactions.user_id AS user_id,
  sum(prices.value * currencies.current_value_in_usd) AS total_usd_value
FROM
  transactions
  JOIN prices ON (prices.transaction_id = transactions.id)
  JOIN currencies ON (currencies.id = prices.currency_id)
WHERE
  transactions.creation_date_time >= now()::date - 365 / 2
  AND transactions.transaction_type = 'expense'
GROUP BY
  transactions.user_id
  
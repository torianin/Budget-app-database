WITH
  users_incomes AS
  (SELECT
    transactions.user_id AS user_id,
    SUM(currencies.current_value_in_usd * prices.value) AS total_usd_value
  FROM
    transactions
    JOIN prices ON (prices.transaction_id = transactions.id)
    JOIN accounts ON (accounts.id = transactions.account_id)
    JOIN currencies ON (currencies.id = accounts.currency_id)
  WHERE
    transactions.transaction_type = 'income'
  GROUP BY
    transactions.user_id
  ),
  users_expenses AS
  (SELECT
    transactions.user_id AS user_id,
    SUM(currencies.current_value_in_usd * prices.value) AS total_usd_value
  FROM
    transactions
    JOIN prices ON (prices.transaction_id = transactions.id)
    JOIN accounts ON (accounts.id = transactions.account_id)
    JOIN currencies ON (currencies.id = accounts.currency_id)
  WHERE
    transactions.transaction_type = 'expense'
  GROUP BY
    transactions.user_id
  )
SELECT
  DISTINCT
  transactions.user_id AS user_id,
  users_incomes.total_usd_value - users_expenses.total_usd_value AS usd_bilance
FROM
  transactions
  JOIN users_incomes ON (users_incomes.user_id = transactions.user_id)
  JOIN users_expenses ON (users_expenses.user_id = transactions.user_id)
WHERE
  transactions.creation_date_time >= now()::date - 30
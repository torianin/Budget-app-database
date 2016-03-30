-- TODO update
SELECT
 short_name, value
FROM
 transactions
 JOIN users ON user_id = users.id
 JOIN categories ON transactions.category_id = categories.id
 JOIN accounts ON account_id = accounts.id
 --JOIN currencies ON currency_id = currencies.id
 JOIN prices ON prices.transaction_id = transactions.id
 JOIN currencies ON prices.currency_id = currencies.id
WHERE
 creation > '2010-01-01'
 AND categories.name = 'Ab';
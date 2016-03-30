SELECT
	transactions.user_id AS user_id,
	min(limits.amount - prices.value) AS limit_left
FROM
	users
	JOIN transactions ON (transactions.user_id = users.id)
	JOIN categories ON (categories.id = transactions.category_id)
	JOIN limits ON (limits.category_id = categories.id)
	JOIN prices ON (prices.transaction_id = transactions.id)
	JOIN currencies ON (currencies.id = prices.currency_id)
WHERE
	transactions.creation_date_time > '2012-01-01'
	AND transactions.creation_date_time < '2017-12-31'
	AND transactions.transaction_type = 'expense'
GROUP BY
	transactions.user_id
ORDER BY
	limit_left ASC
LIMIT 1

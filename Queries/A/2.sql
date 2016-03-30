SELECT 
	SUM(prices.value), COUNT(users.id)
FROM 
	users
	INNER JOIN transactions ON (transactions.user_id = users.id)
	INNER JOIN prices ON (prices.transaction_id = transactions.id) 
WHERE
	creation_date_time >= '2015-03-31'
	AND creation_date_time <= '2017-04-06' AND
	( transactions.transaction_type = 'income' )
GROUP BY 
	users.id
ORDER BY 
	SUM(prices.value)
DESC
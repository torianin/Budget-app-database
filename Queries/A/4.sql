SELECT 
	SUM(prices.value), AVG(prices.value), COUNT(users.id)
FROM 
	users
	INNER JOIN transactions ON (transactions.user_id = users.id)
	INNER JOIN categories ON (categories.category_id = transactions.id) 
	INNER JOIN prices ON (prices.transaction_id = transactions.id) 
WHERE 
	transactions.is_archive IS FALSE
GROUP BY 
	categories.id
ORDER BY 
	SUM(prices.value)
DESC
SELECT 
	currencies.short_name, SUM(prices.value) 
FROM 
	users
	INNER JOIN transactions ON (transactions.user_id = users.id)
	INNER JOIN categories ON (categories.category_id = transactions.id) 
	FULL OUTER JOIN categories As subcategories ON (categories.category_id = categories.id) 
	INNER JOIN prices ON (prices.transaction_id = transactions.id)
	INNER JOIN currencies ON (prices.currency_id = currencies.id)
WHERE categories.name
	NOT LIKE 'Samochód'
GROUP BY 
	currencies.id
HAVING 
	SUM(prices.value) >= 10
ORDER BY 
	SUM(prices.value)
DESC
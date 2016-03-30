SELECT 
	* 
FROM 
	transactions 
	INNER JOIN prices ON (prices.transaction_id = transactions.id)
WHERE 
	creation_date_time >= '2015-03-31'
	AND creation_date_time <= '2017-04-06'
	AND is_archive IS FALSE
ORDER BY value DESC LIMIT 5
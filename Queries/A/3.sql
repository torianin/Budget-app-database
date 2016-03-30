SELECT 
	SUM(p1.value) AS income, 	SUM(p2.value) AS expense
FROM 
	users
	INNER JOIN transactions AS t1 ON (t1.user_id = users.id)
	INNER JOIN transactions AS t2 ON (t2.user_id = users.id)
	INNER JOIN prices AS p1 ON (p1.transaction_id = t1.id)
	INNER JOIN prices AS p2 ON (p2.transaction_id = t2.id)
WHERE
	t1.creation_date_time >= '2015-03-31'
	AND t1.creation_date_time <= '2017-04-06' AND
	t2.creation_date_time >= '2015-03-31'
	AND t2.creation_date_time <= '2017-04-06' AND 
	t1.transaction_type = 'income' AND 
	t2.transaction_type = 'expense' AND
	t1.is_archive IS FALSE AND
	t2.is_archive IS FALSE

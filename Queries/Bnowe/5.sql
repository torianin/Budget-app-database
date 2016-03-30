SELECT
  users.id,
  categories.id,
  sum(prices.value * currencies.current_value_in_usd)
FROM
  users
  JOIN transactions ON (transactions.user_id = users.id)
  JOIN categories ON (categories.id = transactions.category_id)
  JOIN categories_tags ON (categories_tags.category_id = categories.id)
  JOIN tags ON (tags.id = categories_tags.tag_id)
  JOIN prices ON (prices.transaction_id = transactions.id)
  JOIN currencies ON (currencies.id = prices.currency_id)
WHERE
  users.creation > '2012-12-01'
GROUP BY
  users.id,
  categories.id
HAVING
  COUNT(tags.id) >= 1
  AND COUNT(tags.id) <= 4
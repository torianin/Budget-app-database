SELECT
 users.name, users.phone, users.note, users.creation
 --*
FROM
 users
 JOIN transactions ON transactions.user_id = users.id
WHERE
 creation > now()::date
 ;
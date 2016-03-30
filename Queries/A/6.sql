-- Przeniesienie danych sprzedaży starszych niż X lat do archiwum.
UPDATE transactions
SET is_archive='t'
WHERE transactions.creation_date_time <= '2016-04-17'

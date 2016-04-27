CREATE INDEX tags_name_idx ON tags (name);
CREATE INDEX payees_account_number_idx ON payees USING Hash (account_number);
CREATE INDEX users_name ON users (name);
CREATE INDEX transactions_description_idx ON transactions USING gin(to_tsvector('english', description));

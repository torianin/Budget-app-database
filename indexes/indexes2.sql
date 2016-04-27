CREATE INDEX category_name_idx ON categories (name);
CREATE INDEX payee_name_idx ON payees (name);
CREATE INDEX account_balance_idx ON accounts (balance);
CREATE INDEX currency_name_idx ON currencies USING Hash (name);
CREATE INDEX currency_shortname_idx ON currencies USING Hash (short_name);
CREATE INDEX transactions_description_idx ON transactions USING gist(to_tsvector('english', description));
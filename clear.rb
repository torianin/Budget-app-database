require "sequel"

DB = Sequel.connect("postgres://postgres:123@localhost/budget")

tables = [:categories_tags, :tags, :categories, :users, :accounts, :reminders, :currencies, :prices, :recurring_infos, :transactions, :payees, :limits]

tables.each do |table|
	if DB.table_exists?(table)
		DB.drop_table(table, :cascade => true)
	end
end

require "sequel"

DB = Sequel.connect("postgres://localhost/budget")

DB.drop_table(:tags, :categories, :users, :accounts, :reminders, :currencies, :prices, :recurring_infos, :transactions, :payees, :limits, :cascade=>true)

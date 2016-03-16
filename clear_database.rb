require "sequel"

DB = Sequel.connect("postgres://localhost/budget")

DB.drop_table(:users, :accounts, :reminders, :currencies, :prices, :recurring_infos, :transactions, :payees, :limits, :cascade=>true)

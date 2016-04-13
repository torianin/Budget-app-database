require "rubygems"
require "sequel"
require './clear.rb'
require "./create_database.rb"
require './models.rb'
require "./seed.rb"
require 'benchmark'

# Srednia wolumetria
W1 = {
:users_count => 16000,
:currencies_count => 200,
:tags_count => 30000,
:categories_count => 3000,
:accounts_count => 250000,
:recurring_infos_count => 140000,
:reminders_count => 120000,
:transactions_count => 80000,
:prices_count => 80000,
:payees_count => 50000,
:limits_count => 10000
}

# Mniej uzytkownikow, ale czesciej uzywajacych aplikacji
W2 = {
:users_count => 8000,
:currencies_count => 200,
:tags_count => 40000,
:categories_count => 4000,
:accounts_count => 300000,
:recurring_infos_count => 200000,
:reminders_count => 170000,
:transactions_count => 120000,
:prices_count => 120000,
:payees_count => 70000,
:limits_count => 14000
}


# Uzytkownicy maja wiecej transakcji, ale prostych
W3 = {
:users_count => 16000,
:currencies_count => 200,
:tags_count = 1000,
:categories_count => 3000,
:accounts_count => 50000,
:recurring_infos_count => 40000,
:reminders_count => 20000,
:transactions_count => 140000,
:prices_count => 140000,
:payees_count => 10000,
:limits_count => 5000
}

puts Benchmark.measure {
	clearDatabase
	createDatabase
	seedDatabase(W2)
}


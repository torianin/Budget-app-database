require "rubygems"
require "sequel"
require './clear.rb'
require "./create_database.rb"
require './models.rb'
require "./seed.rb"
require 'benchmark'

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

W2 = {
:users_count => 10,
:currencies_count => 10,
:tags_count => 10,
:categories_count => 10,
:accounts_count => 10,
:recurring_infos_count => 10,
:reminders_count => 10,
:transactions_count => 10,
:prices_count => 10,
:payees_count => 10,
:limits_count => 10
}

puts Benchmark.measure {
	clearDatabase
	createDatabase
	seedDatabase(W2)
}
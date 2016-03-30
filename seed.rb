require "faker"

def seedDatabase
	users = DB[:users]
	accounts = DB[:accounts]
	reminders = DB[:reminders]
	currencies = DB[:currencies]
	prices = DB[:prices]
	recurring_infos = DB[:recurring_infos]
	transactions = DB[:transactions]
	payees = DB[:payees]
	limits = DB[:limits]
	categories = DB[:categories]

	(1..50).each do
		users.insert(
			:name => Faker::Name.name,
			:phone => Faker::PhoneNumber.cell_phone,
			:note => Faker::Lorem.sentence(3)
			)
	end

	(1..50).each do
		accounts.insert(
			:name => Faker::Company.name,
			:balance => Faker::Number.decimal(2),
			:account_number => Faker::Bitcoin.address
			)
	end

	(1..50).each do
		reminders.insert(
			:name => Faker::Company.name,
			:description => Faker::Lorem.sentence(3),
			)
	end

	(1..50).each do
		currencies.insert(
			:name => Faker::Company.name,
			:short_name => Faker::Lorem.word[0..2].upcase,
			:date_time => Faker::Date.forward(23),
			:current_value_in_usd => Faker::Commerce.price
			)
	end

	(1..50).each do
		prices.insert(
			:value => Faker::Number.decimal(2),
			)
	end

	(1..50).each do
		recurring_infos.insert(
			:starting_date => Faker::Date.backward(100),
			:end_date => Faker::Date.forward(100),
			:period => ["daily", "weekly", "monthly"].sample
		)
	end

	(1..50).each do
		transactions.insert(
			:description => Faker::Lorem.sentence(3),
			:place => "#{Faker::Address.latitude} #{Faker::Address.longitude}",
			:transaction_type => ["expense", "income"].sample,
			:is_archive => Faker::Boolean.boolean(0.2)
		)
	end

	(1..50).each do
		payees.insert(
			:name => Faker::Name.name,
			:phone => Faker::PhoneNumber.cell_phone,
			:account_number => Faker::Business.credit_card_number,
			:note => Faker::Lorem.sentence(3)
			)
	end

	(1..50).each do
		limits.insert(
			:amount => Faker::Commerce.price,
			)
	end

	(1..50).each do
		categories.insert(
			:name => ["Auto", "Spożywcze", "Sport"].sample,
			:user_id => DB[:users].all.sample[:id]
			)
	end
end
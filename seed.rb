require "faker"

def seedDatabase(users_count, currencies_count, tags_count, categories_count, accounts_count, recurring_infos_count, reminders_count, transactions_count, prices_count, payees_count, limits_count )

	time = Time.now
	puts time.inspect

	puts "DATABASE SEEDING WITH VALUES  users_count : #{users_count}, currencies_count : #{currencies_count}, tags_count : #{tags_count}, categories_count : #{categories_count}, accounts_count : #{accounts_count}, recurring_infos_count : #{recurring_infos_count}, reminders_count : #{reminders_count}, transactions_count : #{transactions_count}, prices_count : #{prices_count}, payees_count : #{payees_count}, limits_count : #{limits_count} ..."

	users = DB[:users]
	currencies = DB[:currencies]
	tags = DB[:tags]
	categories = DB[:categories]
	accounts = DB[:accounts]
	recurring_infos = DB[:recurring_infos]
	reminders = DB[:reminders]
	transactions = DB[:transactions]
	prices = DB[:prices]
	payees = DB[:payees]
	limits = DB[:limits]
	categories_tags = DB[:categories_tags]

	user_data = []
	(0..users_count).each do
		user_data << [
			Faker::Name.name,
			Faker::PhoneNumber.cell_phone,
			Faker::Boolean.boolean(0.15) ? Faker::Lorem.sentence(3) : nil,
			Faker::Date.backward(3000),
			]
	end
	users.import([:name, :phone, :note, :creation], user_data)

	currencies_data = []
	(0..currencies_count).each do
		currencies_data << [
			Faker::Company.name,
			Faker::Lorem.word[0..2].upcase,
			Faker::Date.forward(23),
			Faker::Commerce.price
			]
	end
	currencies.import([:name, :short_name, :date_time, :current_value_in_usd], currencies_data)

	tags_data = []
	(0..tags_count).each do |tag|
		tags_data << [
			Faker::Lorem.word.capitalize,
			Faker::Color.color_name,
			DB[:users].all.sample[:id]
			]
	end
	tags.import([:name, :color, :user_id], tags_data)

	categories_data = []
	(0..categories_count).each do
		categories_data << [
			Faker::Lorem.word.capitalize,
			DB[:users].all.sample[:id],
			Faker::Boolean.boolean(0.2) && !DB[:categories].all.empty? ? DB[:categories].all.sample[:id] : nil
			]
	end
	categories.import([:name, :user_id, :category_id], categories_data)


	accounts_data = []
	(0..accounts_count).each do
		accounts_data << [
			Faker::Company.name,
			Faker::Number.decimal(2),
			Faker::Bitcoin.address,
			DB[:users].all.sample[:id],
			DB[:currencies].all.sample[:id]
			]
	end
	accounts.import([:name, :balance, :account_number, :user_id, :currency_id ], accounts_data)

	recurring_infos_data = []
	(0..recurring_infos_count).each do
		recurring_infos_data << [
			Faker::Date.backward(100),
			Faker::Date.forward(100),
			["daily", "weekly", "monthly"].sample
		]
	end
	recurring_infos.import([:starting_date, :end_date, :period], recurring_infos_data)


	reminders_data = []
	(0..reminders_count).each do
		reminders_data << [
			Faker::Company.name,
			Faker::Lorem.sentence(3),
			DB[:users].all.sample[:id],
			DB[:recurring_infos].all.sample[:id]
			]
	end
	reminders.import([:name, :description, :user_id, :recurring_info_id], reminders_data)

	transactions_data = []
	(0..transactions_count).each do
		transactions_data << [
			Faker::Lorem.sentence(3),
			"#{Faker::Address.latitude} #{Faker::Address.longitude}",
			["expense", "income"].sample,
			Faker::Date.forward(23),
			Faker::Boolean.boolean(0.2),
			DB[:users].all.sample[:id],
			DB[:categories].all.sample[:id],
			DB[:accounts].all.sample[:id],
			DB[:recurring_infos].all.sample[:id]
		]
	end
	transactions.import([:description, :place, :transaction_type, :creation_date_time, :is_archive, :user_id, :category_id, :account_id, :recurring_info_id], transactions_data)


	prices_data = []
	(0..transactions_count).each do |i|
		if Faker::Boolean.boolean(0.5) == true
			prices_data << [
				Faker::Number.decimal(2),
				DB[:transactions].all[i][:id],
				DB[:currencies].all.sample[:id]
				]
		end
	end
	prices.import([:value, :transaction_id, :currency_id], prices_data)

	payees_data = []
	(0..payees_count).each do
		payees_data << [
			Faker::Name.name,
			Faker::PhoneNumber.cell_phone,
			Faker::Business.credit_card_number,
			Faker::Lorem.sentence(3),
			DB[:transactions].all.sample[:id],
			]
	end
	payees.import([:name, :phone, :account_number, :note, :transaction_id], payees_data)


	limits_data = []
	(0..limits_count).each do
		limits_data << [
			Faker::Commerce.price,
			DB[:categories].all.sample[:id],
			DB[:recurring_infos].all.sample[:id],
			]
	end
	limits.import([:amount, :category_id, :recurring_info_id], limits_data)

	used_pairs = []
	(0..tags_count+categories_count).each do
		tag_id = DB[:tags].all.sample[:id]
		category_id = DB[:categories].all.sample[:id]
		if !used_pairs.include?([tag_id, category_id])
		  	categories_tags.insert(
				:tag_id => tag_id,
				:category_id => category_id
			)
		  	used_pairs << [tag_id, category_id]
		end
	end

	time = Time.now
	puts time.inspect
end
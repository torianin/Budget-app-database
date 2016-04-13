require "faker"
require 'thread'

def seedDatabase(seed_values)

	time = Time.now
	puts time.inspect

	puts "DATABASE SEEDING WITH VALUES  seed_values[:users_count] : #{seed_values[:users_count]}, seed_values[:currencies_count] : #{seed_values[:currencies_count]}, seed_values[:tags_count] : #{seed_values[:tags_count]}, seed_values[:categories_count] : #{seed_values[:categories_count]}, seed_values[:accounts_count ]: #{seed_values[:accounts_count]}, seed_values[:recurring_infos_count] : #{seed_values[:recurring_infos_count]}, seed_values[:reminders_count] : #{seed_values[:reminders_count]}, seed_values[:transactions_count] : #{seed_values[:transactions_count]}, seed_values[:prices_count] : #{seed_values[:prices_count]}, seed_values[:payees_count] : #{seed_values[:payees_count]}, seed_values[:limits_count] : #{seed_values[:limits_count]} ..."

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

	threads = []

	threads << Thread.new(seed_values[:users_count]) {
		puts "Creating users"
		$user_data = []
		(0..seed_values[:users_count]).each do
			$user_data << [
				Faker::Name.name,
				Faker::PhoneNumber.cell_phone,
				Faker::Boolean.boolean(0.15) ? Faker::Lorem.sentence(3) : nil,
				Faker::Date.backward(3000),
				]
		end
	}

	threads << Thread.new(seed_values[:currencies_count]) {
		puts "Creating currencies"
		$currencies_data = []
		(0..seed_values[:currencies_count]).each do
			$currencies_data << [
				Faker::Company.name,
				Faker::Lorem.word[0..2].upcase,
				Faker::Date.forward(23),
				Faker::Commerce.price
				]
		end
	}

	threads << Thread.new(seed_values[:users_count], seed_values[:tags_count]) {
		puts "Creating tags"
		$tags_data = []
		(0..seed_values[:tags_count]).each do |tag|
			$tags_data << [
				Faker::Lorem.word.capitalize,
				Faker::Color.color_name,
				Faker::Number.between(1, seed_values[:users_count] )
				]
		end
	}

	threads << Thread.new(seed_values[:categories_count]) {
		puts "Creating categories"
		$categories_data = []
		(0..seed_values[:categories_count]).each do
			$categories_data << [
				Faker::Lorem.word.capitalize,
				Faker::Number.between(1, seed_values[:users_count] ),
				Faker::Boolean.boolean(0.2) && !$categories_data.empty? ? Faker::Number.between(1, $categories_data.size ) : nil
				]
		end
	}

	threads << Thread.new(seed_values[:users_count], seed_values[:currencies_count], seed_values[:accounts_count]) {
		puts "Creating accounts"
		$accounts_data = []
		(0..seed_values[:accounts_count]).each do
			$accounts_data << [
				Faker::Company.name,
				Faker::Number.decimal(2),
				Faker::Bitcoin.address,
				Faker::Number.between(1, seed_values[:users_count] ),
				Faker::Number.between(1, seed_values[:currencies_count] ),
				]
		end
	}

	threads << Thread.new(seed_values[:recurring_infos_count]) {
		puts "Creating recurring infos"
		$recurring_infos_data = []
		(0..seed_values[:recurring_infos_count]).each do
			$recurring_infos_data << [
				Faker::Date.backward(100),
				Faker::Date.forward(100),
				["daily", "weekly", "monthly"].sample
			]
		end
	}

	threads << Thread.new(seed_values[:users_count], seed_values[:recurring_infos_count], seed_values[:reminders_count]) {
		puts "Creating reminders"
		$reminders_data = []
		(0..seed_values[:reminders_count]).each do
			$reminders_data << [
				Faker::Company.name,
				Faker::Lorem.sentence(3),
				Faker::Number.between(1, seed_values[:users_count] ),
				Faker::Number.between(1, seed_values[:recurring_infos_count] )
				]
		end
	}

	threads << Thread.new(seed_values[:transactions_count], seed_values[:users_count], seed_values[:categories_count], seed_values[:accounts_count], seed_values[:recurring_infos_count]) {
		puts "Creating transactions"
		$transactions_data = []
		(0..seed_values[:transactions_count]).each do
			$transactions_data << [
				Faker::Lorem.sentence(3),
				"#{Faker::Address.latitude} #{Faker::Address.longitude}",
				["expense", "income"].sample,
				Faker::Date.forward(23),
				Faker::Boolean.boolean(0.2),
				Faker::Number.between(1, seed_values[:users_count] ),
				Faker::Number.between(1, seed_values[:categories_count] ),
				Faker::Number.between(1, seed_values[:accounts_count] ),
				Faker::Number.between(1, seed_values[:recurring_infos_count] )
			]
		end
	}

	threads << Thread.new(seed_values[:transactions_count], seed_values[:currencies_count]) {
		puts "Creating prices"
		$prices_data = []
		(0..seed_values[:transactions_count]).each do |transactions|
			if Faker::Boolean.boolean(0.5) == true
				$prices_data << [
					Faker::Number.decimal(2),
					transactions + 1,
					Faker::Number.between(1, seed_values[:currencies_count] )
					]
			end
		end
	}

	threads << Thread.new(seed_values[:payees_count], seed_values[:transactions_count]) {
		puts "Creating payees"
		$payees_data = []
		(0..seed_values[:payees_count]).each do
			$payees_data << [
				Faker::Name.name,
				Faker::PhoneNumber.cell_phone,
				Faker::Business.credit_card_number,
				Faker::Lorem.sentence(3),
				Faker::Number.between(1, seed_values[:transactions_count] )
				]
		end
	}

	threads << Thread.new(seed_values[:limits_count], seed_values[:categories_count], seed_values[:recurring_infos_count]) {
		puts "Creating limits"
		$limits_data = []
		(0..seed_values[:limits_count]).each do
			$limits_data << [
				Faker::Commerce.price,
				Faker::Number.between(1, seed_values[:categories_count] ),
				Faker::Number.between(1, seed_values[:recurring_infos_count] )
				]
		end
	}

	threads.each { |thr| thr.join }
	users.import([:name, :phone, :note, :creation], $user_data)
	currencies.import([:name, :short_name, :date_time, :current_value_in_usd], $currencies_data)
	tags.import([:name, :color, :user_id], $tags_data)
	categories.import([:name, :user_id, :category_id], $categories_data)
	accounts.import([:name, :balance, :account_number, :user_id, :currency_id ], $accounts_data)
	recurring_infos.import([:starting_date, :end_date, :period], $recurring_infos_data)
	reminders.import([:name, :description, :user_id, :recurring_info_id], $reminders_data)
	transactions.import([:description, :place, :transaction_type, :creation_date_time, :is_archive, :user_id, :category_id, :account_id, :recurring_info_id], $transactions_data)
	prices.import([:value, :transaction_id, :currency_id], $prices_data)
	payees.import([:name, :phone, :account_number, :note, :transaction_id], $payees_data)
	limits.import([:amount, :category_id, :recurring_info_id], $limits_data)

	used_pairs = []
	(0..seed_values[:tags_count]+seed_values[:categories_count]).each do
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
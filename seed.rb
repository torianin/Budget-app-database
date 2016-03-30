require "faker"

def seedDatabase
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

	(1..50).each do
		users.insert(
			:name => Faker::Name.name,
			:phone => Faker::PhoneNumber.cell_phone,
			:note => Faker::Boolean.boolean(0.15) ? Faker::Lorem.sentence(3) : nil,
			:creation => Faker::Date.backward(3000),
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

	(1..10).each do |tag|
		tags.insert(
			:name => Faker::Lorem.word.capitalize,
			:color => Faker::Color.color_name,
			:user_id => DB[:users].all.sample[:id]
			)
	end


	(1..50).each do
		categories.insert(
			:name => Faker::Lorem.word.capitalize,
			:user_id => DB[:users].all.sample[:id],
			:category_id => Faker::Boolean.boolean(0.2) && !DB[:categories].all.empty? ? DB[:categories].all.sample[:id] : nil
			)
	end

	(1..50).each do
		accounts.insert(
			:name => Faker::Company.name,
			:balance => Faker::Number.decimal(2),
			:account_number => Faker::Bitcoin.address,
			:user_id => DB[:users].all.sample[:id],
			:currency_id => DB[:currencies].all.sample[:id]
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
		reminders.insert(
			:name => Faker::Company.name,
			:description => Faker::Lorem.sentence(3),
			:user_id => DB[:users].all.sample[:id],
			:recurring_info_id => DB[:recurring_infos].all.sample[:id]
			)
	end

	(1..50).each do
		transactions.insert(
			:description => Faker::Lorem.sentence(3),
			:place => "#{Faker::Address.latitude} #{Faker::Address.longitude}",
			:transaction_type => ["expense", "income"].sample,
			:is_archive => Faker::Boolean.boolean(0.2),
			:user_id => DB[:users].all.sample[:id],
			:category_id => DB[:categories].all.sample[:id],
			:account_id => DB[:accounts].all.sample[:id],
			:recurring_info_id => DB[:recurring_infos].all.sample[:id]
		)
	end

	(1..50).each do
		prices.insert(
			:value => Faker::Number.decimal(2),
			:transaction_id => DB[:transactions].all.sample[:id],
			:currency_id => DB[:currencies].all.sample[:id]
			)
	end

	(1..50).each do
		payees.insert(
			:name => Faker::Name.name,
			:phone => Faker::PhoneNumber.cell_phone,
			:account_number => Faker::Business.credit_card_number,
			:note => Faker::Lorem.sentence(3),
			:transaction_id => DB[:transactions].all.sample[:id],
			)
	end

	(1..50).each do
		limits.insert(
			:amount => Faker::Commerce.price,
			:category_id => DB[:categories].all.sample[:id],
			:recurring_info_id => DB[:recurring_infos].all.sample[:id],
			)
	end

	used_pairs = []
	(1..50).each do
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
end
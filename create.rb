def createDatabase
	DB.drop_table(:users, :accounts, :reminders, :currencies, :prices, :recurring_infos, :transactions, :payees, :limits, :cascade=>true)

	DB.create_table! :users do
		primary_key :id
		String :name
		String :phone
		String :note
	end

	DB.create_table! :accounts do
		primary_key :id
		String :name
		Float :balance
		String :account_number
	end

	DB.create_table! :reminders do 
		primary_key :id
		String :name
		String :description
	end

	DB.create_table! :currencies do
		primary_key :id
		String :name
		String :short_name
		DateTime :date_time
		Float :current_value_in_usd
	end

	DB.create_table! :prices do
		primary_key :id
		Float :value
	end

	DB.create_table! :recurring_infos do
		primary_key :id
		DateTime :starting_date
		DateTime :end_date
		String :period
	end

	DB.create_table! :transactions do
		primary_key :id
		String :description
		String :place
		String :transaction_type
		TrueClass :is_archive
	end

	DB.create_table! :payees do
		primary_key :id
		String :name
		String :phone
		String :account_number
		String :note
	end

	DB.create_table! :limits do
		primary_key :id
		Integer :amount
	end
end
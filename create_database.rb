def createDatabase

DB.drop_table(:categories_tags, :tags, :categories, :users, :accounts, :reminders, :currencies, :prices, :recurring_infos, :transactions, :payees, :limits, :cascade=>true)


unless DB.table_exists? (:users)
	DB.create_table :users do
		primary_key :id
		String :name
		String :phone
		String :note
	end
end

unless DB.table_exists? (:currencies)
	DB.create_table :currencies do
		primary_key :id
		String :name
		String :short_name
		DateTime :date_time
		Float :current_value_in_usd
	end
end

unless DB.table_exists? (:tags)
	DB.create_table :tags do
		primary_key :id
		String :name
		String :color
		foreign_key :user_id, :users
	end
end

unless DB.table_exists? (:categories)
	DB.create_table :categories do
		primary_key :id
		String :name
		foreign_key :user_id, :users
		foreign_key :category_id
	end
end


unless DB.table_exists? (:accounts)
	DB.create_table :accounts do
		primary_key :id
		String :name
		Float :balance
		String :account_number
		foreign_key :user_id, :users
		foreign_key :currency_id, :currencies
	end
end

unless DB.table_exists? (:recurring_infos)
	DB.create_table :recurring_infos do
		primary_key :id
		DateTime :starting_date
		DateTime :end_date
		String :period
	end
end

unless DB.table_exists? (:reminders)
	DB.create_table :reminders do 
		primary_key :id
		String :name
		String :description
		foreign_key :user_id, :users
		foreign_key :recurring_info_id, :recurring_infos
	end
end

unless DB.table_exists? (:transactions)
	DB.create_table :transactions do
		primary_key :id
		String :description
		String :place
		String :transaction_type
		TrueClass :is_archive
		foreign_key :user_id, :users
		foreign_key :category_id, :categories
		foreign_key :account_id, :accounts
		foreign_key :recurring_info_id, :recurring_infos
	end
end

unless DB.table_exists? (:prices)
	DB.create_table :prices do
		primary_key :id
		Float :value
		foreign_key :transaction_id, :transactions
		foreign_key :currency_id, :currencies
	end
end

unless DB.table_exists? (:payees)
	DB.create_table :payees do
		primary_key :id
		String :name
		String :phone
		String :account_number
		String :note
		foreign_key :transaction_id, :transactions
	end
end

unless DB.table_exists? (:limits)
	DB.create_table :limits do
		primary_key :id
		Integer :amount
		foreign_key :category_id, :categories
		foreign_key :recurring_info_id, :recurring_infos
	end
end

DB.create_join_table(:tag_id=>:tags, :category_id=>:categories)


end
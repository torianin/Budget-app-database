class Reminder < Sequel::Model
	many_to_one :user
	many_to_one :recurring_infos
end

class Transaction < Sequel::Model
	many_to_one :user
	many_to_one :categories
	many_to_one :accounts
	many_to_one :recurring_infos
	one_to_many :payees
	one_to_many :prices
end

class Account < Sequel::Model
	many_to_one :user
	one_to_many :transactions
	many_to_one :currencies
end

class Tags < Sequel::Model
	many_to_one :user
	many_to_many :categories
end

class Limit < Sequel::Model
	one_to_one :categories
	many_to_one :recurring_infos
end

class Category < Sequel::Model
  many_to_one :user
  many_to_one :categories
  one_to_many :categories
  one_to_many :limits
  one_to_many :transactions
  many_to_many :tags
end

class User < Sequel::Model
  one_to_many :category
  one_to_many :tags
  one_to_many :transactions
  one_to_many :accounts
  one_to_many :reminders
end

class Price < Sequel::Model
	many_to_one :transactions
	many_to_one :currencies
end

class RecurringInfo < Sequel::Model
	one_to_many :transactions
	one_to_many :reminders
	one_to_many :limits
end

class Payee < Sequel::Model
	many_to_one :transactions
end

class Currency < Sequel::Model
	one_to_many :accounts
	one_to_many :prices
end

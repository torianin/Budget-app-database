require "rubygems"
require "sequel"
require './clear.rb'
require "./create_database.rb"
require './models.rb'
require "./seed.rb"
require './custom_logger.rb'
require 'logger'
require 'faker'

def queriesA
	minValue = 1
	maxValue = 50

	loop do 
		minValue += 0
		maxValue += 10

		puts "MIN:#{minValue} MAX:#{maxValue}"
		clearDatabase
		createDatabase
		seedDatabase(minValue,maxValue)

		file = "#{Dir.pwd}/Queries/A/1.sql"
		query1 = File.read(file)

		execute_time = get_execute_time(query1)
		puts execute_time

		x = Transaction.association_join(:prices).where(:creation_date_time => Faker::Date.forward(0)..Faker::Date.forward(10)).where(:is_archive => false).order(Sequel.desc(:value)).limit(5)
		#puts x.sql 
		#x.each{|r| p r}

 		break if execute_time > 5.0
	end 
end
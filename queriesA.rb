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
		puts "MIN:#{minValue} MAX:#{maxValue}"
		clearDatabase
		createDatabase
		seedDatabase(minValue,maxValue)

		execute_times = []

		(1..5).each do |i|
			file = "#{Dir.pwd}/Queries/A/#{i}.sql"
			query1 = File.read(file)

			execute_time = get_execute_time(query1)
			puts execute_time
			execute_times << execute_time
		end

		puts execute_times
		#puts x.sql 
		#x.each{|r| p r}

 		break if true

 		minValue += 0
		maxValue += 100
	end 
end
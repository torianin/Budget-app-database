require "rubygems"
require "sequel"
require './clear.rb'
require './models.rb'
require './custom_logger.rb'
require 'logger'
require 'faker'
require 'terminal-table'

@@rows = []

def queries(command, name)
	execute_time_sum = []
	execute_times_a = []

	@@rows << ['', '',name,'']

	clearDatabase
	wasGood = system( command )

	execute_times_a = []
	(1..6).each do |i|
		file = "#{Dir.pwd}/Queries/A/#{i}.sql"
		query1 = File.read(file)
		execute_time = 0.0
		(0..3).each do |j|
			execute_time = execute_time + get_execute_time(query1)
		end
		puts execute_time
		execute_times_a << execute_time
	end
	execute_times_a << (execute_times_a.inject{ |sum, el| sum + el }.to_f / execute_times_a.size)

	puts execute_times_a
	#puts x.sql 
	#x.each{|r| p r}
	puts "OK"

	execute_times_b = []
	(1..6).each do |i|
		file = "#{Dir.pwd}/Queries/B/#{i}.sql"
		query1 = File.read(file)

		execute_time = 0.0
		(0..1).each do |j|
			execute_time = execute_time + get_execute_time(query1)
		end
		puts execute_time
		execute_times_b << execute_time
	end
	execute_times_b << (execute_times_b.inject{ |sum, el| sum + el }.to_f / execute_times_b.size)

	puts execute_times_a
	#puts x.sql 
	#x.each{|r| p r}

	puts "OK"

	execute_time_sum << (execute_time_sum.inject{ |sum, el| sum + el }.to_f / execute_time_sum.size)
	@@rows << ['','A','B','Suma']
	(1..6).each do |i|
		execute_time_sum << execute_times_a[i] + execute_times_b[i]
		@@rows << [i,'%.4f' % execute_times_a[i], '%.4f' % execute_times_b[i], '%.4f' %execute_time_sum[i]]
	end
	@@rows << ["N",3,3,3]
	@@rows << ["AVG",'%.4f' % execute_times_a[5],'%.4f' % execute_times_a[5], '%.4f' % execute_time_sum[5]]
end

queries('pg_restore -U torianin -O -x -d budget /Users/torianin/Budget-app-database/W1.dat','W1')
queries('pg_restore -U torianin -O -x -d budget /Users/torianin/Budget-app-database/W2.dat','W2')
queries('pg_restore -U torianin -O -x -d budget /Users/torianin/Budget-app-database/W3.dat','W3')

table = Terminal::Table.new :title => "Czas wykonania operacji na danych dla N powtórzeń", :rows => @@rows
puts table
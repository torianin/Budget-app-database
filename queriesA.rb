require "rubygems"
require "sequel"
require './config.rb'
require 'logger'
require 'faker'
require 'terminal-table'
require 'database_cleaner'

UserConfig = ENV['USER'] == 'torianin' ? RobertsConfig.new : SzymonsConfig.new

DB = Sequel.connect(UserConfig.database_url, :loggers => [Logger.new($stdout)])

class DatabaseHelper

	def initialize
		@rows = []
	end

	def clearDB()
		cleanScript = "#{Dir.pwd}/scripts/cleardb.sql"
		query1 = File.read(cleanScript)
		DB.run query1
	end

	def setIndexes(number)
		indexes = "#{Dir.pwd}/indexes/indexes#{number}.sql"
		query1 = File.read(indexes)
		DB.run query1
	end

	def queries(command, name, indexNumber = 0)
		execute_time_sum = []
		execute_times_a = []
		
		load './custom_logger.rb'

		@rows << ['', '',name,'']

		clearDB

		wasGood = system( command )

		load './models.rb'

		if !indexNumber
			setIndexes(indexNumber)
		end

		execute_times_a = []
		(1..5).each do |i|
			puts "A#{i}"
			file = "#{Dir.pwd}/queries/A/#{i}.sql"
			query1 = File.read(file)
			execute_time = 0.0
			(0..10).each do |j|
				execute_time = execute_time + get_execute_time(query1)
			end
			puts execute_time
			execute_times_a << execute_time
		end
		execute_times_a << (execute_times_a.reduce(0, :+).to_f / execute_times_a.size)

		puts execute_times_a

		execute_times_b = []
		(1..5).each do |i|
			puts "B#{i}"
			file = "#{Dir.pwd}/queries/B/#{i}.sql"
			query1 = File.read(file)

			execute_time = 0.0
			(0..10).each do |j|
				execute_time = execute_time + get_execute_time(query1)
			end
			puts execute_time
			execute_times_b << execute_time
		end
		execute_times_b << (execute_times_b.reduce(0, :+).to_f / execute_times_b.size)

		puts execute_times_a

		execute_time_sum << (execute_time_sum.reduce(0, :+).to_f / execute_time_sum.size)
		@rows << ['','A','B','Suma']
		(1..5).each do |i|
			execute_time_sum << execute_times_a[i] + execute_times_b[i]
			@rows << [i,'%.4f' % execute_times_a[i], '%.4f' % execute_times_b[i], '%.4f' %execute_time_sum[i]]
		end
		@rows << ["N",10,10,10]
		@rows << ["AVG",'%.4f' % execute_times_a[5],'%.4f' % execute_times_a[5], '%.4f' % execute_time_sum[5]]
	end

	def runTests
		username = UserConfig.username
		path = UserConfig.path

		(0..2).each do |k|
			@rows = []
			(1..3).each do |i|
				#queries("pg_restore -U #{username} -O -x -d budget #{path}/backups/backupW1prim.dat","W#{i}",k)
				queries("pg_restore -U #{username} -O -x -d budget #{path}/backups/W#{i}.dat","W#{i}",k)

			end
			table = Terminal::Table.new :title => "Czas wykonania operacji na danych dla N powtórzeń", :rows => @rows
			File.open("#{Dir.pwd}/results/test_#{Time.now.getutc.to_s}_index_#{k}.txt", 'w') { |file| file.write(table) }
			puts table
		end
	end
end

databaseHelper = DatabaseHelper.new
databaseHelper.runTests
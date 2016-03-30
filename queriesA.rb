require 'Logger'

def queriesA
	DB.loggers << Logger.new(STDOUT)
	DB.sql_log_level = :debug
	puts DB.run("select * from users")


end
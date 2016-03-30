require 'stringio'
require 'logger'

def get_execute_time(sql_command)
	strio = StringIO.new
	l = Logger.new strio
	DB.loggers << l
	DB.execute(sql_command)
	puts "#{sql_command} => #{/\((.*)s\)/.match(strio.string)[1]}"
	return /\((.*)s\)/.match(strio.string)[1].to_f
end
require './custom_logger.rb'

def queriesA
	get_execute_time("select * from users")

	DB[:transactions].where(:salary => 5000..10000).order(:name, :department)

end
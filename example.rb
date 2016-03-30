require "rubygems"
require "sequel"
require "./create_database.rb"
require "./seed.rb"
require './queriesA.rb'

DB = Sequel.connect("postgres://postgres:123@localhost/budget", )

require './models.rb'

createDatabase
seedDatabase
queriesA

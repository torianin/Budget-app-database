require "rubygems"
require "sequel"
require "./create_database.rb"
require "./seed.rb"

DB = Sequel.connect("postgres://localhost/budget")

createDatabase
seedDatabase
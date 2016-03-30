require "rubygems"
require "sequel"
require './clear.rb'
require "./create_database.rb"
require './models.rb'
require "./seed.rb"
require './queriesA.rb'

clearDatabase
createDatabase
seedDatabase(1,50)
queriesA

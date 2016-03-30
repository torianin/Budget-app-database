require "rubygems"
require "sequel"
require "./create_database.rb"
require "./seed.rb"
require './queriesA.rb'
require './clear.rb'
require './models.rb'

createDatabase
seedDatabase

DB.loggers << Logger.new($stdout)

queriesA

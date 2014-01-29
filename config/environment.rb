require 'bundler'
Bundler.require :default, :test

$:.unshift File.expand_path("./../../lib", __FILE__)

db_options = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(db_options)

require 'ideabox'
require 'bundler'
Bundler.require :default, :test


$:.unshift File.expand_path("./../../lib", __FILE__)

require 'ideabox/db_config'

# the quick-and-dirty way, part deux
environment = ENV.fetch('RACK_ENV') { 'development' }
config = DBConfig.new(environment).options
ActiveRecord::Base.establish_connection(config)
require 'ideabox'
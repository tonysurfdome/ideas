ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require :test, :default
require_relative '../config/environment'

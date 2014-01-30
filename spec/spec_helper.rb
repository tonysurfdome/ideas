ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require :test, :default
require_relative '../config/environment'

RSpec.configure do |c|
  c.around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end

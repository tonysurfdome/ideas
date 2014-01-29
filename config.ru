$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("..", __FILE__)

require 'bundler'
Bundler.require :default

require 'config/environment'
require 'puma'
require 'api'

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run IdeaboxAPI
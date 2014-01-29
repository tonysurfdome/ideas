require 'bundler'
Bundler.require :default

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'app'

run IdeaboxApp

require 'rubygems'
require 'sinatra'
require 'activerecord'
require 'redirect'

root_dir = File.dirname(__FILE__)

set :environment, ENV['RACK_ENV'].to_sym || :development
set :root,        root_dir
set :run,         false

db_config = YAML::load(File.open("#{File.dirname(__FILE__)}/config/database.yml"))[Sinatra::Application.environment.to_s]
ActiveRecord::Base.establish_connection(db_config)

run Sinatra::Application


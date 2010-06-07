require 'rubygems'
require 'sinatra'
require 'activerecord'
require 'redirect'

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql',
  :database => 'trackster_development',
  :username => 'root',
  :encoding => 'utf8',
  :pool => 5,
  :timeout  => 5000
)

root_dir = File.dirname(__FILE__)

set :environment, ENV['RACK_ENV'].to_sym || :development
set :root,        root_dir
set :run, false

run Sinatra::Application


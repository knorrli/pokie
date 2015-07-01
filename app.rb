require 'rubygems'
require 'sinatra'
require 'net/http'
require 'uri'
require 'json'
require 'pry'
require 'sinatra/activerecord'

require './models/form'
require './models/configuration'
require './models/request'
require './models/patches'

set :database, {adapter: "sqlite3", database: "dev.sqlite3"}
set :show_exceptions, true

def load_configurations
  @configurations = Configuration.all
  @configuration = Configuration.find_or_initialize params["configuration_id"]
end

get '/' do
  load_configurations
  @form = Form.new @configuration.form_attributes
  erb :index
end

get '/request' do
  redirect '/'
end
post '/request' do
  load_configurations
  @form = Form.new params
  @form.submit_request
  erb :index
end

get '/load_configuration' do
  redirect '/'
end
post '/load_configuration' do
  load_configurations
  @form = Form.new @configuration.form_attributes
  erb :index
end

get '/save_configuration' do
  redirect '/'
end
post '/save_configuration' do
  load_configurations
  @form = Form.new params
  @form.save
  @configuration = @form.configuration
  erb :index
end


require 'sinatra/base'
require './config/environment'
require 'rack-flash'
require_relative '../helpers/authentication_helper'

# Base controller for the sinatra application
class ApplicationController < Sinatra::Base
  enable :sessions
  use RackSessionAccess::Middleware if environment == :test
  use Rack::Flash, sweep: true
  helpers Sinatra::AuthenticationHelper
  # configure :production, :development do
  #   enable :logging
  # end
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['secret']
  end

  get '/' do
    erb :'home/index'
  end

  not_found do
    erb :not_found
  end
end

require 'sidekiq'
require_relative '../../workers/send_sign_up_email'

class UsersController < ApplicationController
  ['/users/log_in'].each do |path|
    before path do
      next unless request.post?

      @user = User.find_by(username: params[:username])
    end
  end

  get '/users/sign_in' do
    erb :'users/login'
  end

  get '/users/sign_up' do
    erb :'users/sign_up'
  end

  post '/users/sign_up' do
    user = User.new(params)
    if user.save
      flash[:success] = ['You have been registered successfully']
      SendSignUpEmail.perform_async(user.id)
      redirect '/'
    else
      status 400
      flash[:danger] = user.errors.full_messages
      erb :'users/sign_up'
    end
  end

  post '/users/log_in' do
    if @user && @user.authenticate(params[:password])
      flash[:success] = ['Logged in successfully']
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}/user_profile"
    else
      status 400
      flash[:danger] = ['Invalid username or password']
      erb :'users/login'
    end
  end

  get '/users/logout' do
    session[:user_id] = nil
    flash[:success] = ['You have successfully logged out']
    redirect '/'
  end

  get '/users/:user_id/user_profile' do
    @current_user = User.find(params[:user_id])
    @businesses = @current_user.businesses
    erb :'users/user_profile'
  end
end

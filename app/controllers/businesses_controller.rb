class BusinessesController < ApplicationController
  %w[/users/register_business
     /businesses/:business_id/profile
     /businesses/:business_id/add_review
     /businesses/:business_id/edit].each do |path|
    before path do
      login_required!
      @categories = Category.all
      # next unless request.post?
    end
  end

  get '/businesses' do
    @businesses = Business.all
    status 200
    erb :'businesses/catalog'
  end

  get '/users/register_business' do
    erb :'businesses/register'
  end

  post '/users/register_business' do
    business = Business.new(params)
    business[:user_id] = @current_user.id
    if business.save
      flash[:success] = ['Business registered successfully']
      redirect '/businesses'
    else
      status 400
      flash[:danger] = business.errors.full_messages
      erb :'businesses/register'
    end
  end

  get '/businesses/:business_id/profile' do
    @business = Business.find_by(id: params[:business_id])
    halt status 404 if @business.nil?
    @reviews = @business.reviews
    erb :'businesses/business_profile'
  end

  delete '/businesses/:business_id/delete' do
    business = Business.find_by(id: params[:business_id])
    if business
      business.destroy
      flash[:success] = ['Business deleted successfully']
      halt status 200
    end
    halt status 404
  end

  post '/businesses/:business_id/add_review' do
    review = Review.new(params)
    review[:user_id] = @current_user.id
    if review.save
      flash[:success] = ['Business review added successfully']
      redirect "/businesses/#{params[:business_id]}/profile"
    else
      status 400
      flash[:danger] = review.errors.full_messages
      erb :'businesses/register'
    end
  end

  get '/businesses/:business_id/edit' do
    @business = Business.find(params[:business_id])
    erb :'businesses/edit'
  end

  put '/businesses/:business_id/edit' do
    @business = Business.find(params[:business_id])
    business_attributes = params.except(:business_id)
    if @business.update(business_attributes)
      flash[:success] = ['Business updated successfully']
      halt status 200
    else
      flash[:danger] = @business.errors.full_messages
      halt status 400
    end
  end
end

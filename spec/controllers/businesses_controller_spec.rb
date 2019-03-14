require_relative '../spec_helper.rb'

RSpec.describe BusinessesController do
  describe 'get ' do
    let!(:user) { create :user }
    let!(:business) { create :business }

    context 'logged in user' do
      it 'should access the business catalog page' do
        get '/businesses', {}, 'rack.session' => { user_id: user.id }

        expect(last_response).to be_ok
        expect(last_response.body).to include('business-card')
      end

      it 'should access the register business template' do
        get '/users/register_business', {},
            'rack.session' => { user_id: user.id }

        expect(last_response).to be_ok
      end
    end

    context 'unauthenticated user' do
      it 'should not access the register business template' do
        get '/users/register_business'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.url).to eq('http://example.org/users/sign_in')
      end
    end
  end

  describe 'post ' do
    let!(:business_params) { attributes_for :business }
    let!(:user) { create :user }
    let!(:category) { create :category }
    context 'valid business params' do
      it 'registers the business successfully' do
        business_params[:category_id] = category.id
        post '/users/register_business', business_params,
             'rack.session' => { user_id: user.id }
        expect(Business.find_by(
                 business_name: business_params[:business_name]
               )).not_to be_nil
      end
    end

    context 'invalid business params' do
      it 'fails to register the business' do
        business_params[:business_name] = nil
        post '/users/register_business', business_params,
             'rack.session' => { user_id: user.id }
        expect(last_response).to be_bad_request
      end
    end
  end

  describe 'put' do
    let!(:user) { create :user }
    let!(:business) { create :business, user: user }
    context 'valid business param update' do
      it 'updates the business successfully' do
        put "/businesses/#{business.id}/edit",
            { business_name: 'New Name' },
            'rack.session' => { user_id: user.id }
        expect(Business.find(business.id).business_name).to eq 'New Name'
      end
    end

    context 'invalid business update param' do
      it 'fails to register the business' do
        put "/businesses/#{business.id}/edit",
            { business_name: '' },
            'rack.session' => { user_id: user.id }
        expect(last_response).to be_bad_request
      end
    end
  end

  describe 'deleting' do
    let!(:user) { create :user }
    let!(:business) { create :business, user: user }
    context 'business with permissions' do
      it 'deletes the business successfully' do
        delete "/businesses/#{business.id}/delete",
               {}, 'rack.session' => { user_id: user.id }
        expect(last_response).to be_ok
      end
    end

    context 'business does not exist' do
      let!(:new_business) { create :business }
      it 'fails to delete the business' do
        delete '/businesses/12345/delete',
               {}, 'rack.session' => { user_id: user.id }
        expect(last_response).to be_not_found
      end
    end
  end
end

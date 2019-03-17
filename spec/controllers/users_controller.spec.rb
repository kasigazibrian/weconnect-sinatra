require_relative '../spec_helper.rb'

RSpec.describe UsersController do
  describe '#signup' do
    let(:user_attributes) { attributes_for :user }

    context 'signing up process' do
      it 'should sign up a user' do
        post '/users/sign_up', user_attributes

        expect(User.find_by(username: user_attributes[:username])).not_to be_nil
      end

      it 'should fail to sign up a user with invalid attributes' do
        user_attributes[:username] = nil
        post '/users/sign_up', user_attributes

        expect(last_response).to be_bad_request
      end
    end
  end

  describe '#login' do
    let!(:user) { create :user, password: 'mango' }
    let!(:user_credentials) do
      { username: user.username, password: 'mango' }
    end
    context 'logging in process' do
      it 'should log in a user' do
        post '/users/log_in', user_credentials

        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.url)
          .to eq("http://example.org/users/#{user.id}/user_profile")
      end

      it 'should fail to log in a user with invalid credentials' do
        user_credentials[:password] = 'wrong_password'
        post '/users/log_in', user_credentials

        expect(last_response).to be_bad_request
      end
    end
  end
end

require_relative '../spec_helper.rb'

RSpec.describe 'The login process', type: :feature, js: true do
  let(:user) { create :user, password: 'mango' }
  describe 'User #Login' do
    before :each do
      visit '/users/sign_in'
    end
    it 'loads the login page successfully' do
      expect(page).to have_content(/Please Log in/)
      expect(page).to have_field('Password')
      expect(page).to have_field('Username')
    end
    it 'logs in a user' do
      fill_in 'username', with: user.username
      fill_in 'password', with: 'mango'
      click_button 'Log In'
      sleep 1
      expect(page).to have_content(/User Profile/)
      expect(page).to have_content('Logged in successfully')
    end

    it 'fails to login a user with invalid credentials' do
      fill_in 'username', with: 'wrong username'
      fill_in 'password', with: 'wrong password'
      click_button 'Log In'
      sleep 1
      expect(page).to have_content('Invalid username or password')
    end
  end

  describe 'logs out a user' do
    it 'logs out a user' do
      page.set_rack_session(user_id: user.id)

      visit '/users/logout'
      sleep 1
      expect(page).to have_content('You have successfully logged out')
    end
  end
end

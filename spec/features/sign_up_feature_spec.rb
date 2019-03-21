require_relative '../spec_helper.rb'

RSpec.describe 'The sign up process', type: :feature, js: true do
  describe 'User #Signup' do
    before :each do
      visit '/users/sign_up'
    end
    it 'loads the sign up page successfully' do
      expect(page).to have_content(/Please Sign up/)
      expect(page).to have_field('First Name')
      expect(page).to have_field('Last Name')
      expect(page).to have_field('Username')
    end
    it 'signs up a user' do
      fill_in 'username', with: 'Brian'
      fill_in 'email', with: 'brian@andela.com'
      fill_in 'first_name', with: 'brian'
      fill_in 'last_name', with: 'Moses'
      choose('male')
      fill_in 'password', with: 'mango12345'
      fill_in 'password_confirmation', with: 'mango12345'
      click_button 'Sign Up'
      expect(page).to have_content(/Welcome !!/)
      expect(page).to have_content('You have been registered successfully')
    end

    it 'fails to sign up a user with invalid information' do
      fill_in 'username', with: 'Brian'
      fill_in 'email', with: 'brian.com'
      fill_in 'first_name', with: 'brian'
      fill_in 'last_name', with: 'Moses'
      choose('male')
      fill_in 'password', with: 'mango12345'
      fill_in 'password_confirmation', with: ''
      click_button 'Sign Up'
      sleep 1
      expect(page).to have_content(
        "Password confirmation doesn't match Password"
      )
      expect(page).to have_content(
        'Email should be a valid Andela email address'
      )
    end
  end
end

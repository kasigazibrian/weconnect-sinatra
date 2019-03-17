require_relative '../spec_helper.rb'

RSpec.describe 'The login up process', type: :feature, js: true do
  let!(:user) { create :user, password: 'mango' }
  let!(:category) { create :category, name: 'business' }
  describe 'Business #Register' do
    before :each do
      page.set_rack_session(user_id: user.id)
      visit '/users/register_business'
    end
    it 'loads the register page successfully' do
      expect(page).to have_content(/Business Registration Form/)
      expect(page).to have_field('Business Name')
      expect(page).to have_field('Business Email')
      expect(page).to have_field('Business Location')
      expect(page).to have_field('Business Category')
      expect(page).to have_field('Contact Number')
      expect(page).to have_field('Business Description')
    end

    it 'logs in a user' do
      fill_in 'business_name', with: 'BMW'
      fill_in 'business_email', with: 'bmw@gmail.com'
      fill_in 'business_location', with: 'Germany'
      select('business', from: 'category_id')
      fill_in 'contact_number', with: '256781712939'
      fill_in 'business_description', with: 'Best business ever'
      click_button 'Register Business'
      sleep 1
      expect(page).to have_selector('.business-card')
      expect(page).to have_content('Business registered successfully')
    end
  end
end

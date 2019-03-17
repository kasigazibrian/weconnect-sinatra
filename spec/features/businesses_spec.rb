RSpec.describe 'Business', type: :feature, js: true do
  let!(:user) { create :user }
  let!(:category) { create :category, name: 'business' }
  let!(:owned_business) { create :business, user: user }
  let!(:business) { create :business, category: category }
  describe '#Allbusinesses' do
    before :each do
      page.set_rack_session(user_id: user.id)
    end
    it 'displays the business successfully' do
      visit '/businesses'
      sleep 1
      expect(page).to have_selector('.business-card')
      expect(page).to have_content(business.business_name)
    end

    it 'displays the business profile page' do
      visit "/businesses/#{business.id}/profile"
      sleep 1
      expect(page).to have_content(business.business_name)
      expect(page).to have_content(business.business_email)
      expect(page).to have_content(business.contact_number)
      expect(page).to have_content(business.business_description)
      expect(page).to have_content(business.business_location)
      expect(page).to have_content(category.name)
    end

    it 'adds a business review' do
      visit "/businesses/#{business.id}/profile"
      sleep 1
      fill_in 'title', with: 'First review'
      fill_in 'body', with: 'This is the best business'
      click_button 'Add Review'
      expect(page).to have_content('Business review added successfully')
      sleep 1
      click_link 'Show Reviews'
      expect(page).to have_content('This is the best business')
    end

    it 'allows editing a business' do
      visit "/businesses/#{owned_business.id}/profile"
      click_button ''
    end
  end
end

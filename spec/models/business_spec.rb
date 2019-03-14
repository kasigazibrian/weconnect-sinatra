require_relative '../spec_helper.rb'

RSpec.describe Business, type: :model do
  let!(:business) { create :business }

  describe 'model' do
    context 'associations' do
      it { should belong_to(:user) }
      it { should have_many(:reviews) }
      it { should belong_to(:category) }
    end

    context 'presence validation' do
      it do
        should validate_presence_of(:business_name)
          .with_message('is a required field')
      end
      it do
        should validate_presence_of(:business_email)
          .with_message('is a required field')
      end
    end
    context 'uniqueness validation' do
      it do
        should validate_uniqueness_of(:business_name)
          .with_message('has already been taken')
      end
      it do
        should validate_uniqueness_of(:business_email)
          .with_message('has already been taken')
      end
      it do
        should validate_uniqueness_of(:contact_number)
          .with_message('already exists').case_insensitive
      end
    end
    context 'format validation' do
      it do
        should allow_value('brian@gmail.com').for(:business_email)
      end
      it do
        should_not allow_value('brian').for(:business_email)
      end
      it do
        should_not allow_value('phone').for(:contact_number)
      end
      it do
        should allow_value('256781712925').for(:contact_number)
      end
    end
  end
end

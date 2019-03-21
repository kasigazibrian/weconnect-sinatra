require_relative '../spec_helper.rb'

RSpec.describe Business, type: :model do
  let!(:business) { create :business }
  let!(:filter_params) do
    { has_name: business.business_name,
      in_location: business.business_location }
  end

  describe 'model' do
    context 'associations' do
      it { should belong_to(:user) }
      it { should have_many(:reviews) }
      it { should belong_to(:category) }
    end

    context 'filters' do
      it 'should filter businesses with filter params' do
        expect(described_class.filter(filter_params))
          .to eq([business])
      end
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

require_relative '../spec_helper.rb'

RSpec.describe User, type: :model do
  describe 'User model' do
    context 'associations' do
      it do
        should have_many(:businesses)
      end
    end
    context 'presence validation' do
      it do
        should validate_presence_of(:username).with_message(
          'is a required field'
        )
      end
    end
    context 'uniqueness validation' do
      subject { FactoryBot.create(:user) }
      it do
        should validate_uniqueness_of(:username).ignoring_case_sensitivity
      end
    end
  end
end

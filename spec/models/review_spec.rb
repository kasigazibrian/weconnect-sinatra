require_relative '../spec_helper.rb'

RSpec.describe Review, type: :model do
  describe 'Review model' do
    context 'associations' do
      it { should belong_to(:business) }
    end
    context 'presence validation' do
      it do
        should validate_presence_of(:title)
          .with_message('is a required field')
      end
      it do
        should validate_presence_of(:body)
          .with_message('is a required field')
      end
    end

    context 'length validation' do
      it do
        should validate_length_of(:title).is_at_least(5)
      end
      it do
        should validate_length_of(:body).is_at_least(10)
      end
    end
  end
end

require_relative '../spec_helper.rb'

RSpec.describe BusinessesController, type: :controller do
  describe 'post' do
    let!(:user) { create :user }
    let!(:business) { create :business, user: user }
    let!(:review_params) { attributes_for :review }

    context 'valid review params' do
      it 'should add review successfully' do
        post "/businesses/#{business.id}/add_review",
             review_params, 'rack.session' => { user_id: user.id }
        expect(business.reviews).not_to be_nil
      end
    end

    context 'invalid review params' do
      it 'should fail to add review' do
        review_params[:title] = nil
        post "/businesses/#{business.id}/add_review", review_params,
             'rack.session' => { user_id: user.id }
        expect(last_response).to be_bad_request
      end
    end
  end
end

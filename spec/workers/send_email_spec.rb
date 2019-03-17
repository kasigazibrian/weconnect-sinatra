require_relative '../spec_helper'

RSpec.describe SendEmail do
  let!(:user) { create :user }
  before(:each) do
    allow(Pony).to receive(:mail)
  end

  it 'sends mail' do
    expect(Pony).to receive(:mail) do |mail|
      expect(mail[:to]).to eq user.email
      expect(mail[:subject]).to eq 'SIGN UP SUCCESSFUL'
    end
    SendEmail.send_mail(user)
  end
end

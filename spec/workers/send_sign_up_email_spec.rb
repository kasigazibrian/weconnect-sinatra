require_relative '../spec_helper'

RSpec.describe SendSignUpEmail do
  let!(:user) { create :user }

  it 'queues the jobs' do
    expect do
      SendSignUpEmail.perform_async(user.id)
    end.to change(SendSignUpEmail.jobs, :size).by(1)
  end

  it 'fails to perform the job with incorrect user_id' do
    SendSignUpEmail.perform_async('fake_id')
    SendSignUpEmail.drain
    expect(SendSignUpEmail.jobs.size).to eq(0)
  end

  it 'performs task' do
    Sidekiq::Testing.inline!
    allow(SendEmail).to receive(:send_mail)
    SendSignUpEmail.perform_async(user.id)
    expect(SendEmail).to have_received(:send_mail)
  end
end

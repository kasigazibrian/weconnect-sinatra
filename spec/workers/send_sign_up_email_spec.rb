require_relative '../spec_helper'
# require 'shoryuken'

RSpec.describe SendSignUpEmail do
  let!(:user) { create :user }

  let(:sqs_msg) do
    double message_id: 'fc754df7-9cc2-4c41-96ca-5996a44b771e',
           body: 'test',
           delete: nil
  end

  let(:body) { 'test' }
  describe '#perform' do
    subject { SendSignUpEmail.new }

    before :each do
      allow(SendSignUpEmail).to receive(:perform_async) do |sqs_msg, body|
        subject.perform(sqs_msg, body)
      end
    end

    it 'prints the body message when job fails' do
      expect { subject.perform(sqs_msg, body) }
        .to output("Job failed\n").to_stdout
    end

    it 'performs the send email task' do
      allow(SendEmail).to receive(:send_mail)
      expect { subject.perform(sqs_msg, user.id) }
        .to output("Sending email\n").to_stdout
    end
  end
end

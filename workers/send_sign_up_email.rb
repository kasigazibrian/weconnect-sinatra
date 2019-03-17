require_relative './../config/environment'
require 'sidekiq'
require_relative '../config/pony_config'
require_relative 'send_email'

class SendSignUpEmail
  include Sidekiq::Worker
  sidekiq_options retry: false
  uri = URI.parse(ENV['REDISCLOUD_URL'] || 'redis://localhost:6379/')
  @redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

  def perform(user_id)
    p user_id
    user = User.find_by(id: user_id)
    if user
      puts 'Sending email '
      SendEmail.send_mail(user)
    else
      puts 'Job failed'
    end
  end
end

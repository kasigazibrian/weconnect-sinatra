require 'pony'

require_relative '../config/pony_config'

class SendEmail
  def self.send_mail(user)
    email_body = "<body> Hello #{user.username}!!"\
             '<h1>Thanks for signing up!</h1>'\
             '<h5>Thanks for joining and have a great day! Now sign in and '\
             'do awesome things!</h5>'\
             '</body>'
    Pony.mail(to: user.email, subject: 'SIGN UP SUCCESSFUL',
              html_body: email_body)
  end
end

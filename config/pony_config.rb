require 'pony'

Pony.options = {
  via: :smtp,
  via_options: {
    address: 'smtp.mailgun.org',
    port: 587,
    user_name: ENV['USERNAME'],
    password: ENV['PASSWORD'],
    authentication: :plain,
    enable_starttls_auto: true,
    domain: 'sandboxcae9cf4a336e48ed8b256d432fbd4501.mailgun.org'
  },
  from: 'weconnect@gmail.com'
}

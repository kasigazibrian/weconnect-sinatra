web: bundle exec rackup config.ru -p $PORT
worker: bundle exec shoryuken -q send_email -r ./workers/send_sign_up_email.rb -C ./config/shoryuken.yml


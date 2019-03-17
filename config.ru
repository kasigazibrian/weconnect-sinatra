require './config/environment'
require './app/controllers/application_controller'
require './app/controllers/users_controller'
require './app/controllers/businesses_controller'
require 'sidekiq/web'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

map('/sidekiq') { run Sidekiq::Web }

use UsersController
use BusinessesController
run ApplicationController

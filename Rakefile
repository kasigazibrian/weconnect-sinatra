require_relative './config/environment'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app/controllers/application_controller'

Dir.glob('lib/tasks/*.rake').each { |task| load task }

task :console do
  Pry.start
end

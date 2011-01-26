# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require "heroku_backup_task"

Kzak::Application.load_tasks

task :cron do
  HerokuBackupTask.execute
end

RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'digest/md5'
  require 'yaml'
  CONFIG = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {}).merge(ENV)
  CONFIG['s3'] = true if CONFIG['s3_access_id'] && CONFIG['s3_secret_key'] && CONFIG['s3_bucket_name']  
  config.frameworks -= [:active_resource, :action_mailer]
  config.time_zone = 'UTC'
  config.middleware.use 'NoWWW' if RAILS_ENV == 'production'
  config.action_controller.session = {
    :key => CONFIG['session_key'],
    :secret => CONFIG['session_secret']
  }
end

SessionsController.class_eval do
  skip_before_filter :authenticate_user!, :only => [:new, :create]
end

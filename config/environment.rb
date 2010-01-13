RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'digest/md5'
  require 'smtp-tls'
  require 'yaml'
  CONFIG = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {}).merge(ENV)
  CONFIG['s3'] = true if CONFIG['s3_access_id'] && CONFIG['s3_secret_key'] && CONFIG['s3_bucket_name']
  config.frameworks -= [:active_resource]
  config.time_zone = 'UTC'
  config.middleware.use 'NoWWW' if RAILS_ENV == 'production'
  config.gem 'devise'
  config.action_controller.session = {
    :key => CONFIG['session_key'],
    :secret => CONFIG['session_secret']
  }
end

HoptoadNotifier.configure do |config|
  config.api_key = CONFIG['hoptoad_key']
  config.ignore_only = []
end if CONFIG['hoptoad_key']

if CONFIG['smtp_address']
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => CONFIG['smtp_address'],
    :port => CONFIG['smtp_port'],
    :domain => CONFIG['smtp_domain'],
    :user_name => CONFIG['smtp_user_name'],
    :password => CONFIG['smtp_password'],
    :authentication => CONFIG['smtp_authentication'].to_sym,
    :enable_starttls_auto => CONFIG['smtp_enable_starttls_auto']
  }
end
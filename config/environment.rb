RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'yaml'
  CONFIG = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {}).merge(ENV)
  CONFIG['s3'] = true if CONFIG['s3_access_id'] && CONFIG['s3_secret_key'] && CONFIG['s3_bucket_name']
  CONFIG['host'] = CONFIG['domain'].gsub('http://', '').gsub('https://', '') rescue ''
  config.frameworks -= [:active_resource]
  config.time_zone = 'UTC'
  config.middleware.use 'NoWWW' if RAILS_ENV == 'production'
  # TODO this seems necessary for rails 2.3.5 / bundler 0.9 / passenger 2.2.9
  config.gem 'devise'
  config.gem 'carrierwave'
  config.gem 'hoptoad_notifier'
  config.action_mailer.default_url_options = { :host => CONFIG['host'] }
  config.action_controller.session = {
    :key => CONFIG['session_key'],
    :secret => CONFIG['session_secret']
  }
end
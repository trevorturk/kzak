RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'digest/md5'
  require 'yaml'
  CONFIG = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {}).merge(ENV)
  CONFIG['s3'] = true if CONFIG['s3_access_id'] && CONFIG['s3_secret_key'] && CONFIG['s3_bucket_name']  
  config.frameworks -= [:active_resource, :action_mailer]
  config.time_zone = 'UTC'
  config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :version => '2.3.0'
  config.gem 'right_aws', :version => '1.9.0'
  config.gem 'right_http_connection', :version => '1.2.4'
  config.gem 'ruby-mp3info', :lib => 'mp3info', :version => '0.6.13'
  config.gem 'mime-types', :lib => 'mime/types', :version => '1.16'
  config.gem 'warden', :version => '0.6.4'
  config.gem 'devise', :version => '0.5.5'
  config.action_controller.session = {
    :key => CONFIG['session_key'],
    :secret => CONFIG['session_secret']
  }
end

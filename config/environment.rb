RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'yaml'
  CONFIG = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {}).merge(ENV)
  CONFIG['s3'] = true if CONFIG['s3_access_id'] && CONFIG['s3_secret_key'] && CONFIG['s3_bucket_name']
  CONFIG['host'] = CONFIG['domain'].gsub('http://', '').gsub('https://', '') rescue ''
  config.frameworks -= [:active_resource]
  config.time_zone = 'UTC'
  config.middleware.use 'NoWWW' if RAILS_ENV == 'production'
  config.action_mailer.default_url_options = {:host => CONFIG['host']}
  config.action_controller.session = {:key => CONFIG['session_key'], :secret => CONFIG['session_secret']}
  config.gem "warden", :version => '0.10.4'
  config.gem "devise", :version => '1.0.7'
  config.gem "hoptoad_notifier", :version => '2.2.2'
  config.gem "carrierwave", :version => '0.4.5'
  config.gem "mp4info", :version => '1.7.3'
  config.gem "aws-s3", :version => '0.6.2', :lib => "aws/s3"
  config.gem "ambethia-smtp-tls", :version => '1.1.2', :lib => "smtp-tls"
  config.gem "mime-types", :version => '1.16', :lib => "mime/types"
  config.gem "ruby-mp3info", :version => '0.6.13', :lib => "mp3info"
end
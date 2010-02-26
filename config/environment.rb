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
  config.action_mailer.default_url_options = {:host => CONFIG['host']}
  config.action_controller.session = {:key => CONFIG['session_key'], :secret => CONFIG['session_secret']}
  config.gem "warden"
  config.gem "devise"
  config.gem "hoptoad_notifier"
  config.gem "carrierwave"
  config.gem "aws-s3", :lib => "aws/s3"
  config.gem "ambethia-smtp-tls", :lib => "smtp-tls"
  config.gem "mime-types", :lib => "mime/types"
  config.gem "ruby-mp3info", :lib => "mp3info"
  config.gem "MP4Info", :lib => "mp4info"
end
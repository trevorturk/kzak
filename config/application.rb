require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

# load config.yml and ENV (Heroku config vars included) into CONFIG hash
require 'yaml'
CONFIG = (YAML.load_file('config/config.yml')[Rails.env] rescue {}).merge(ENV)
CONFIG['s3'] = true if CONFIG['s3_access_id'] && CONFIG['s3_secret_key'] && CONFIG['s3_bucket_name']
CONFIG['host'] = CONFIG['domain'].gsub('http://', '').gsub('https://', '') rescue ''
# for heroku s3 backup gem
ENV['s3_access_key_id'] ||= CONFIG['s3_access_id']
ENV['s3_secret_access_key'] ||= CONFIG['s3_secret_key']

module Kzak
  class Application < Rails::Application
    config.session_store :cookie_store, :key => CONFIG['session_key'], :secret => CONFIG['session_secret']
    config.secret_token = CONFIG['secret_token']
    config.action_mailer.default_url_options = {:host => CONFIG['host']}
    config.middleware.use Rack::NoWWW if Rails.env.production?
    config.time_zone = 'UTC'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end

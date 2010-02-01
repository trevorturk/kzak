clear_sources
source "http://gems.rubyforge.org"
source "http://gems.github.com" # for ambethia-smtp-tls

bundle_path "vendor/bundler_gems"

gem "rails", "2.3.5"
gem "warden", "0.8.1"
gem "devise", "0.8.2"
gem "carrierwave", "0.4.4"
gem "aws-s3", "0.6.2", :require_as => "aws/s3"
gem "hoptoad_notifier", "2.1.3"
gem "ambethia-smtp-tls", "1.1.2", :require_as => "smtp-tls"
gem "mime-types", "1.16", :require_as => "mime/types"
gem "ruby-mp3info", "0.6.13", :require_as => "mp3info"
gem "MP4Info", "0.3.3", :require_as => "mp4info"

only :test do
  gem "faker", "0.3.1"
  gem "mocha", "0.9.8"
  gem "machinist", "1.0.6"
  gem "populator", "0.2.5"
end
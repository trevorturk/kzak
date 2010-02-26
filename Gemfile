source "http://rubygems.org"
source "http://gems.github.com" # for ambethia-smtp-tls

gem "rails", "2.3.5"
gem "warden", "0.9.4"
gem "devise", "1.0.3"
gem "hoptoad_notifier", "2.1.3"
gem "carrierwave", "0.4.4"
gem "aws-s3", "0.6.2", :require => "aws/s3"
gem "ambethia-smtp-tls", "1.1.2", :require => "smtp-tls"
gem "mime-types", "1.16", :require => "mime/types"
gem "ruby-mp3info", "0.6.13", :require => "mp3info"
gem "MP4Info", "0.3.3", :require => "mp4info"

group :development do
  gem "sqlite3-ruby", "1.2.5", :require => "sqlite3"
end

group :production do
  gem "pg", "0.8.0"
end

group :test do
  gem "faker", "0.3.1"
  gem "mocha", "0.9.8"
  gem "machinist", "1.0.6"
  gem "populator", "0.2.5"
end
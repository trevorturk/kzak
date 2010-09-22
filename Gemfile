source 'http://rubygems.org'

gem 'rails', '3.0.0'
gem 'devise', '1.1.2'
gem 'hoptoad_notifier', '2.3.7'
gem 'carrierwave', :git => 'git://github.com/jnicklas/carrierwave.git', :ref => '1003d623f350fc353c31'
gem 'fog', '0.2.30'
gem 'mime-types', '1.16', :require => "mime/types"
gem 'ruby-mp3info', '0.6.13', :require => "mp3info"
gem 'mp4info', '1.7.3'
gem 'toadhopper', '1.0.4'
gem 'heroku_s3_backup', :git => 'git://github.com/kamui/heroku_s3_backup.git'

group :production do
  gem 'thin', '1.2.7'
  gem 'pg', '0.9.0'
end

group :development do
  gem 'sqlite3-ruby', '1.3.0', :require => 'sqlite3'
  gem 'heroku', '1.10.5'
end

group :test do
  gem 'sqlite3-ruby', '1.3.0', :require => 'sqlite3'
  gem 'populator', '0.2.5'
  gem 'machinist', '1.0.6'
  gem 'faker', '0.3.1'
  gem 'autotest-rails', '4.1.0'
  gem 'mocha', '0.9.8'
end

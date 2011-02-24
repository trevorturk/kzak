source 'http://rubygems.org'

gem 'rails'
gem 'devise'
gem 'hoptoad_notifier'
gem 'mime-types', :require => "mime/types"
gem 'ruby-mp3info', :require => "mp3info"
gem 'mp4info'
gem 'toadhopper'
gem 'yajl-ruby'
gem 'heroku_backup_task'
gem 'flash_cookie_session'
gem 'fog', '0.5.3'

# gem 'carrierwave', :path => '~/code/carrierwave'
gem 'carrierwave', :git => 'git://github.com/jnicklas/carrierwave.git', :ref => '6804a7e033412d186542'
# gem 'carrierwave', '0.5.2'

group :production do
  gem 'thin'
  gem 'pg'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'heroku'
  gem 'ruby-debug'
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'populator'
  gem 'machinist'
  gem 'faker'
  gem 'autotest-rails'
  gem 'mocha'
end

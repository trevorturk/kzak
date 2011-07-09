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

# gem 'carrierwave', :path => '~/code/carrierwave'
# gem 'carrierwave', :git => 'git://github.com/jnicklas/carrierwave.git', :ref => '3f4d5bd88db8768e35e0'
gem 'carrierwave', '0.5.5'

gem 'fog', '0.7.1'

group :production do
  gem 'thin'
  gem 'pg'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'ruby-debug19', :platforms => [:ruby_19]
  gem 'ruby-debug', :platforms => [:ruby_18, :jruby]
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'populator'
  gem 'machinist'
  gem 'faker'
  gem 'autotest-rails'
  gem 'mocha'
end

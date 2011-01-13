desc "cache assets"
task :cache_assets => :environment do
  javascript = 'public/javascripts/all.js'
  stylesheet = 'public/stylesheets/all.css'

  FileUtils.rm(javascript) if File.exist?(javascript)
  FileUtils.rm(stylesheet) if File.exist?(stylesheet)

  ActionController::Base.perform_caching = true

  session = ActionDispatch::Integration::Session.new(Rails.application)
  session.get('/')
  session.follow_redirect!

  %x[git add #{javascript}]
  %x[git add #{stylesheet}]
  %x[git commit 'cache_assets']
end

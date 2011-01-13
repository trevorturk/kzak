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

  system("git add #{javascript}") ? puts("git add #{javascript}") : fail
  system("git add #{stylesheet}") ? puts("git add #{stylesheet}") : fail
  system("git commit -m 'cache_assets'") ? puts("git commit -m 'cache_assets'") : fail
end

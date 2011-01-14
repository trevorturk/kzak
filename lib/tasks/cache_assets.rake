desc "cache assets"
task :cache_assets => :environment do
  puts "-----> caching assets"

  paths = ['public/javascripts/all.js', 'public/stylesheets/all.css']

  paths.each do |path|
    FileUtils.rm(path) if File.exist?(path)
  end

  ActionController::Base.perform_caching = true

  session = ActionDispatch::Integration::Session.new(Rails.application)
  session.get('/')
  session.follow_redirect!

  paths.each do |path|
    if File.exist?(path)
      system("git add #{path}") ? true : fail
    end
  end

  paths.each do |path|
    @changes = true if File.exist?(path)
  end

  if @changes
    puts "-----> committing cached assets"
    system("git commit -m 'cache_assets'") ? true : fail
  else
    puts "-----> no cached assets found"
  end

  puts "-----> done"
end

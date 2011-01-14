desc "cache assets"
task :cache_assets => :environment do

  paths = ['public/javascripts/all.js', 'public/stylesheets/all.css']

  puts "-----> caching assets..."
  paths.each do |path|
    puts "-----> #{path}"
  end

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

  if %x[git diff-index HEAD].present?
    puts "-----> committing cached assets"
    system("git commit -m 'cache_assets'") ? true : fail
  else
    puts "-----> nothing to commit"
  end

  puts "-----> done"
end

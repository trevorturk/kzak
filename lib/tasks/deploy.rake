desc "deploy"
task :deploy => :environment do
  puts "running rake cache_assets"
  Rake::Task['cache_assets'].invoke
  puts "pushing to github..."
  %x[git push origin master]
  puts "deploying to heroku..."
  %x[git push heroku master]
  puts "done..."
end

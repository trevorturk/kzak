desc "deploy"
task :deploy => :environment do
  system("rake cache_assets") ? puts("rake cache_assets") : fail
  system("git push origin master") ? puts("git push origin master") : fail
  system("git push heroku master") ? puts("git push heroku master") : fail
end

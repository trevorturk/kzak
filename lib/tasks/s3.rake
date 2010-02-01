namespace :s3 do
  task :create => :environment do
    puts "Reading config/config.yml and creating a bucket on s3 for the production environment..."
    CONFIG = YAML.load_file('config/config.yml')['production'] rescue {}
    AWS::S3::Base.establish_connection!(
      :access_key_id => CONFIG['s3_access_id'],
      :secret_access_key => CONFIG['s3_secret_key']
    )
    AWS::S3::Bucket.create(CONFIG['s3_bucket_name'], :access => :private)
    puts "OK" if AWS::S3::Bucket.find(CONFIG['s3_bucket_name'])
  end
end
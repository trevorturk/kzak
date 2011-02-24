if CONFIG['s3']
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => CONFIG['s3_access_id'],
      :aws_secret_access_key  => CONFIG['s3_secret_key']
    }
    config.fog_directory  = CONFIG['s3_bucket_name']
    config.fog_host       = CONFIG['s3_host_alias']
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000', 'Expires' => 99.years.from_now.httpdate}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

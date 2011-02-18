if CONFIG['s3']
  CarrierWave.configure do |config|
    config.s3_access_key_id = CONFIG['s3_access_id']
    config.s3_secret_access_key = CONFIG['s3_secret_key']
    config.s3_bucket = CONFIG['s3_bucket_name']
    config.s3_access_policy = :public_read
    config.s3_headers = {'Cache-Control' => 'max-age=315576000', 'Expires' => 99.years.from_now.httpdate}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

# TODO use carrierwave's cname support instead (or fog)
CarrierWave::Storage::S3::File.class_eval do
  def url
    if CONFIG['s3_host_alias']
      "http://#{CONFIG['s3_host_alias']}/#{@path}"
    else
      "http://s3.amazonaws.com/#{@uploader.s3_bucket}/#{@path}"
    end
  end
end

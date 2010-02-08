if CONFIG['s3']
  CarrierWave.configure do |config|
    config.s3_access_key_id = CONFIG['s3_access_id']
    config.s3_secret_access_key = CONFIG['s3_secret_key']
    config.s3_bucket = CONFIG['s3_bucket_name']
    config.s3_access = :public_read
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

# TODO use carrierwave's cname support instead?
CarrierWave::Storage::S3::File.class_eval do
  def url
    "http://s3.amazonaws.com/#{@uploader.s3_bucket}/#{@path}"
  end
end

# TODO remove when this is fixed in carrierwave http://github.com/jnicklas/carrierwave/issues#issue/36
CarrierWave::Uploader::Store.class_eval do
  def store_path(for_file=filename)
    File.join([store_dir, full_filename(for_file)].compact)
  end
end
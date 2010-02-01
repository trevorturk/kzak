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

CarrierWave::Storage::S3::File.class_eval do
  def url
    if @uploader.s3_cnamed
      ["http://", @uploader.s3_bucket, "/", @path].compact.join
    else
      ["http://s3.amazonaws.com/", @uploader.s3_bucket, @path].compact.join
    end
  end
end
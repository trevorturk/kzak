# encoding: utf-8

require 'carrierwave/orm/activerecord'

class Mp3Uploader < CarrierWave::Uploader::Base

  if CONFIG['s3']
    def store_dir
      nil
    end
  else
    def store_dir
      'system'
    end
  end

  def filename
    @random_filename ||= ActiveSupport::SecureRandom.hex(20)
    "#{@random_filename}#{File.extname(original_filename).downcase}" if original_filename
  end

end

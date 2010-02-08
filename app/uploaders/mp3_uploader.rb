# encoding: utf-8

require 'carrierwave/orm/activerecord'

class Mp3Uploader < CarrierWave::Uploader::Base

  if CONFIG['s3']
    storage :s3
    def store_dir
      nil
    end
  else
    storage :file
    def store_dir
      "system"
    end
  end

  def filename
    @random_filename ||= ActiveSupport::SecureRandom.hex(20)
    "#{@random_filename}#{File.extname(original_filename).downcase}" if original_filename
  end

  def s3_headers
    # TODO specify globally when gem gets fixed http://github.com/jnicklas/carrierwave/issues/closed#issue/32
    {'Cache-Control' => 'max-age=315576000', 'Expires' => 99.years.from_now.httpdate}
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads" # for heroku read-only filesystem http://codingfrontier.com/carrierwave-on-heroku
  end
end
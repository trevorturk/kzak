class AddS3UrlToUploads < ActiveRecord::Migration
  def self.up
    add_column :posts, :s3_url, :string
  end

  def self.down
    remove_column :posts, :s3_url, :string
  end
end

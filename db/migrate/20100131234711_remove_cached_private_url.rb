class RemoveCachedPrivateUrl < ActiveRecord::Migration
  def self.up
    remove_column :posts, :s3_url
    remove_column :posts, :s3_url_created_at
  end

  def self.down
  end
end

class AddS3UrlCreatedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :s3_url_created_at, :datetime
  end

  def self.down
    remove_column :posts, :s3_url_created_at, :datetime
  end
end

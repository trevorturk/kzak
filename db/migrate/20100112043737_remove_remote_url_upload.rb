class RemoveRemoteUrlUpload < ActiveRecord::Migration
  def self.up
    remove_column :posts, :attachment_remote_url
  end

  def self.down
    add_column :posts, :attachment_remote_url, :string
  end
end

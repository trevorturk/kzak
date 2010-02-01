class RenameAttachmentToMp3 < ActiveRecord::Migration
  def self.up
    rename_column :posts, :attachment_file_name, :mp3
  end

  def self.down
    rename_column :posts, :mp3, :attachment_file_name
  end
end

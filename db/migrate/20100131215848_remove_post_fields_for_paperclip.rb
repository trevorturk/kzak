class RemovePostFieldsForPaperclip < ActiveRecord::Migration
  def self.up
    remove_column :posts, :attachment_content_type
    remove_column :posts, :attachment_file_size
  end

  def self.down
  end
end

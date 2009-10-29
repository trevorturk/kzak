class AddMp3AttrsToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :title, :string
    add_column :posts, :artist, :string
    add_column :posts, :album, :string
  end

  def self.down
    remove_column :posts, :album
    remove_column :posts, :artist
    remove_column :posts, :title
  end
end

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.integer :posts_count, :default => 0, :null => false
      t.integer :followings_count, :default => 0, :null => false
      t.integer :followers_count, :default => 0, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :poster_id
      t.datetime :post_created_at
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :feed_items
  end
end

class IndexFeedItemsOnUserId < ActiveRecord::Migration
  def self.up
    add_index :feed_items, :user_id
  end

  def self.down
    remove_index :feed_items, :user_id
  end
end

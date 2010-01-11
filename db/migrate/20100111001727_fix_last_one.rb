class FixLastOne < ActiveRecord::Migration
  def self.up
    rename_column :users, :inviter, :inviter_id
  end

  def self.down
    rename_column :users, :inviter_id, :inviter
  end
end

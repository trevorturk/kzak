class ChangeInvitedByToInviterId < ActiveRecord::Migration
  def self.up
    rename_column :users, :invited_by, :inviter
  end

  def self.down
    rename_column :users, :inviter, :invited_by
  end
end

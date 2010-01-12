class AddRedeemedAtToInvitations < ActiveRecord::Migration
  def self.up
    add_column :invitations, :redeemed_at, :datetime
  end

  def self.down
    remove_column :invitations, :redeemed_at
  end
end

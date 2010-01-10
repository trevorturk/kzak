class AddNewUserIdToInvitations < ActiveRecord::Migration
  def self.up
    add_column :invitations, :new_user_id, :integer
  end

  def self.down
    remove_column :invitations, :new_user_id
  end
end

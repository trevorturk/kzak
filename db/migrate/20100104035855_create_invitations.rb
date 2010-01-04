class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :user_id
      t.string :email
      t.string :code
      t.timestamps
    end
    add_column :users, :invited_by, :integer
  end

  def self.down
    drop_table :invitations
    remove_column :users, :invited_by
  end
end

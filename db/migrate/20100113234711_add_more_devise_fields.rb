class AddMoreDeviseFields < ActiveRecord::Migration
  def self.up
    # recoverable and trackable
    add_column :users, :reset_password_token, :string, :limit => 20
    add_column :users, :sign_in_count, :integer
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
  end

  def self.down
    remove_column :users, :reset_password_token, :string, :limit => 20
    remove_column :users, :sign_in_count, :integer
    remove_column :users, :current_sign_in_at, :datetime
    remove_column :users, :last_sign_in_at, :datetime
    remove_column :users, :current_sign_in_ip, :string
    remove_column :users, :last_sign_in_ip, :string
  end
end
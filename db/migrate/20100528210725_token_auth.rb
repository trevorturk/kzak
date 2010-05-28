class TokenAuth < ActiveRecord::Migration
  def self.up
    add_column :users, :authentication_token, :string
    User.find_each do |u|
      u.reset_authentication_token
      u.save(false)
    end
  end

  def self.down
    remove_column :users, :authentication_token, :string
  end
end

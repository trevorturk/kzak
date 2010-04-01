class RemoveNilFollowings < ActiveRecord::Migration
  def self.up
    Follow.find_each do |f|
      f.destroy unless f.follower.present? && f.following.present?
    end
  end

  def self.down
  end
end

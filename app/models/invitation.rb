class Invitation < ActiveRecord::Base
  
  attr_accessible :email
  
  belongs_to :user
  validates_presence_of :user_id, :email
  before_create :generate_code
  
  def generate_code
    code = ActiveSupport::SecureRandom.hex(32)
  end
  
end

class Invitation < ActiveRecord::Base
  
  attr_accessible :email
  
  belongs_to :user
  validates_presence_of :user_id, :email
  validates_format_of :email, :with => Devise::EMAIL_REGEX
  before_create :generate_code
  
  def generate_code
    self.code = ActiveSupport::SecureRandom.hex(32)
  end
  
end

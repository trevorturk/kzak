class Invitation < ActiveRecord::Base

  attr_accessible :email

  belongs_to :user

  validates_presence_of :user_id, :email
  validates_format_of :email, :with => Devise::EMAIL_REGEX
  validate :validate_email_is_not_already_in_use

  before_create :generate_code

  def generate_code
    self.code = ActiveSupport::SecureRandom.hex(16)
  end

  def validate_email_is_not_already_in_use
    errors.add(:email, 'is already in use') if User.find_by_email(email)
  end

end

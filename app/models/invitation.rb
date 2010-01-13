class Invitation < ActiveRecord::Base

  attr_accessible :email

  belongs_to :user
  belongs_to :new_user, :class_name => 'User'

  validates_presence_of :user_id, :email
  validates_format_of :email, :with => Devise::EMAIL_REGEX
  validate :validate_email_is_not_already_in_use, :if => :new_record?

  before_create :generate_code

  def validate_email_is_not_already_in_use
    errors.add(:email, 'is already in use') if User.find_by_email(email)
  end

  def generate_code
    self.code = ActiveSupport::SecureRandom.hex(20)
  end

  def redeem_for(user)
    self.code = nil
    self.new_user = user
    self.redeemed_at = Time.zone.now
    self.save!
  end
end
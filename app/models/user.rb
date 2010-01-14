class User < ActiveRecord::Base

  attr_accessible :login, :password, :password_confirmation, :email
  attr_reader :invitation # for users/new action

  devise :authenticatable, :rememberable, :trackable # see config/initializers/devise.rb

  has_many :posts, :order => 'posts.created_at DESC'
  has_many :feed_items, :order => 'feed_items.post_created_at DESC'
  has_many :invitations, :order => 'invitations.created_at DESC'

  has_many :follows_where_they_are_doing_the_following, :foreign_key => :follower_id, :class_name => 'Follow'
  has_many :followings, :through => :follows_where_they_are_doing_the_following, :order => 'users.login DESC'

  has_many :follows_where_they_are_being_followed, :foreign_key => :following_id, :class_name => 'Follow'
  has_many :followers, :through => :follows_where_they_are_being_followed, :order => 'users.login DESC'

  belongs_to :inviter, :class_name => 'User'

  validates_presence_of :login, :email
  validates_length_of :login, :maximum => 15
  validates_format_of :login, :with => /^[a-zA-Z0-9\_]*?$/, :message => "can only contain letters, numbers and underscores"
  validates_format_of :login, :with => /^[a-zA-Z]/, :message => "must begin with a letter"
  validates_format_of :email, :with => Devise::EMAIL_REGEX
  validates_uniqueness_of :login
  validates_presence_of :password
  validates_confirmation_of :password, :if => :password_required?

  default_scope :order => 'login ASC'

  def follow(user)
    Follow.create {|r| r.follower = self; r.following = user}
  end

  def unfollow(user)
    Follow.find_by_follower_id_and_following_id(self.id, user.id).destroy rescue nil
  end

  def following?(user)
    Follow.find_by_follower_id_and_following_id(self.id, user.id).present?
  end

  def follow_all_users
    User.find_each do |existing_user|
      self.follow(existing_user)
    end
  end

  def get_followed_by_all_users
    User.find_each do |existing_user|
      existing_user.follow(self)
    end
  end

  def to_param
    login
  end

  def to_s
    login
  end

  protected

  def password_required?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
end
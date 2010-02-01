class UsersController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :deauthenticate_user!, :only => [:new, :create]

  def show
    @user = User.find_by_login! params[:id], :include => [{:posts => :user}, :followings, :followers]
  end

  def new
    @invitation = Invitation.find_by_code! params[:invitation]
  end

  def create
    @invitation = Invitation.find_by_code! params[:user][:invitation]
    @user = User.new(params[:user])
    @user.inviter = @invitation.user
    if @user.save
      @invitation.redeem_for(@user)
      @user.follow_all_users
      @user.get_followed_by_all_users
      sign_in @user
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  protected

  def deauthenticate_user!
    sign_out current_user if user_signed_in?
  end
end
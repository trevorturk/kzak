class UsersController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :deauthenticate_user!, :only => [:new, :create]

  def show
    @user = User.find_by_login!(params[:id], :include => [:posts, :followings, :followers])
  end

  def new
  end

  def create
    # track invited_by
    # save used invitations
    # invite new users and create initial follows
  end

  protected

  def deauthenticate_user!
    sign_out current_user if user_signed_in?
  end

end

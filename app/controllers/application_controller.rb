class ApplicationController < ActionController::Base
  helper :all
  # protect_from_forgery # TODO figure out why this isn't working
  filter_parameter_logging :password, :password_confirmation
    
  def require_login
    redirect_to bullshit and return false unless user_signed_in?
  end
  
end

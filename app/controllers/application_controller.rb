class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation
  
  def current_user
    @current_user ||= ((session[:user_id] && User.find_by_id(session[:user_id])) || 0)
  end
  
  def logged_in?()
    current_user != 0
  end
        
  def require_login
    redirect_to login_path and return false unless logged_in?
  end
  
end

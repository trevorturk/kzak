class ApplicationController < ActionController::Base
  helper :all
  # protect_from_forgery # TODO figure out why this isn't working
  filter_parameter_logging :password, :password_confirmation
    
  def current_user
    @current_user ||= User.first
  end
  
end

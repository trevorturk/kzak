class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  before_filter :authenticate_user!
end

# require signed in user for entire app aside from sign in actions
SessionsController.class_eval do
  skip_before_filter :authenticate_user!, :only => [:new, :create]
end
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'test_help'

class ActiveSupport::TestCase
  
  setup do
    Sham.reset
  end
  
  def login!(options = {})
    user = User.make(options)
    @request.session[:user_id] = user.id
    user
  end
      
end

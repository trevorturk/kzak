module ApplicationHelper
  
  def new_post_path_for_swf_upload
    session_key = ActionController::Base.session_options[:key]
    posts_path(session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token)
  end
  
end

module ApplicationHelper
  def rss_url
    "#{posts_url(:format => 'rss')}?auth_token=#{current_user.authentication_token}"
  end
end
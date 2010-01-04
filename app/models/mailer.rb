class Mailer < ActionMailer::Base
  
  default_url_options[:host] = CONFIG['domain'].gsub('http://', '').gsub('https://', '') rescue ''
  
  def invitation(invitation)
    subject       "#{CONFIG['app_name']} invitation from #{invitation.user}"
    recipients    invitation.email
    from          CONFIG['mailer']
    sent_on       Time.now.utc
    body          :user => invitation.user, :code => invitation.code
  end

end

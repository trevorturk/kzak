class Mailer < ActionMailer::Base

  def invitation(invitation)
    subject       "#{CONFIG['app_name']} invitation from #{invitation.user}"
    recipients    invitation.email
    from          CONFIG['mailer']
    sent_on       Time.zone.now
    body          :user => invitation.user, :code => invitation.code
  end
end
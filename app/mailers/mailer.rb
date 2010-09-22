class Mailer < ActionMailer::Base
  default :from => CONFIG['mailer']

  def invitation(invitation)
    @invitation = invitation
    mail(:to => invitation.email,
         :subject => "#{CONFIG['app_name']} invitation from #{invitation.user}")
  end

end

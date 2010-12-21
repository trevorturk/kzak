class InvitationsController < ApplicationController

  def create
    @invitation = current_user.invitations.new params[:invitation]
    if @invitation.save
      Mailer.invitation(@invitation).deliver
      render :partial => 'invitations/success.html.erb'
    else
      render :partial => 'invitations/error.html.erb'
    end
  end
end
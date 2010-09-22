class InvitationsController < ApplicationController

  def create
    @invitation = current_user.invitations.new params[:invitation]
    if @invitation.save
      Mailer.invitation(@invitation).deliver
      render :partial => 'success'
    else
      render :partial => 'error'
    end
  end
end
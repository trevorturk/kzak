class InvitationsController < ApplicationController
  
  def create
    @invitation = current_user.invitations.new params[:invitation]
    if @invitation.save
      Mailer.deliver_invitation(@invitation)
      flash[:notice] = "Invitation sent"
      redirect_to root_path
    else
      flash[:error] = "Sorry, there was an error"
      redirect_to root_path
    end
  end
  
end

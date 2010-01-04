class InvitationsController < ApplicationController
  
  def create
    @invitation = current_user.invitations.new params[:invitation]
    if @invitation.save
      flash[:notice] = "Invitation sent"
      redirect_to root_path
    else
      flash[:notice] = "Sorry, there was an error"
      redirect_to root_path
    end
  end
  
end

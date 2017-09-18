class InvitesController < ApplicationController

  def create
    @invite = Invite.new(invite_params)
    @invite.update_attributes(sender_id: current_user.id,
    recipient_id: User.find_by(email: params[:invite][:email]).id)
    if @invite.save
      if @invite.recipient != nil
        @invite.recipient.received_invites << @invite
        flash[:success] = "An invite was sent to #{@invite.recipient.email}."
      else
        flash[:danger] = "This user does not exist."
      end
    else
      flash[:danger] = "There was an error inviting this person."
    end
    redirect_to team_path(@invite.team)
  end

  def destroy
    @invite = Invite.find(params[:id])
    if @invite.destroy
      redirect_to request.referrer
    else
      flash[:danger] = "Error"
    end
  end

  private

    def invite_params
      params.require(:invite).permit(:email, :team_id)
    end
end

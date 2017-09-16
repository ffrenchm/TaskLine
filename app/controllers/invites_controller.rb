class InvitesController < ApplicationController

  def create
    @invite = Invite.new(invite_params)
    @invite.update_attributes(sender_id: current_user.id,
    recipient_id: User.find_by(email: params[:invite][:email]).id)
    if @invite.save
      if @invite.recipient != nil
        @invite.recipient.received_invites << @invite
      else
        flash[:danger] = "This user does not exist."
      end
    else
      flash[:danger] = "There was an error inviting this person."
    end
    redirect_to teams_path
  end

  def destroy
    @invite = Invite.find(params[:id])
    if @invite.destroy
      redirect_to inbox_path
    else
      flash[:danger] = "Error"
    end
  end

  private

    def invite_params
      params.require(:invite).permit(:email, :team_id)
    end
end

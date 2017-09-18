class Teams::MembershipsController < ApplicationController
  before_action :signed_in_user

  def create
    team = Team.find(params[:team_id])
    current_user.join(team)
    invite = Invite.find_by(recipient_id: current_user.id, team_id: team.id)
    invite.destroy if invite
    redirect_to team
  end

  def destroy
    membership = Membership.find(params[:id])
    team = membership.team
    if membership.admin == true || team.users.count == 1
      team.destroy
    else
      current_user.leave(team)
    end
    redirect_to teams_path
  end
end

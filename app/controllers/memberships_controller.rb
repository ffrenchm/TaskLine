class MembershipsController < ApplicationController
  before_action :signed_in_user
  
  def create
    team = Team.find(params[:team_id])
    current_user.join(team)
    redirect_to team
  end

  def destroy
    team = Membership.find(params[:id]).team
    current_user.leave(team)
    redirect_to teams_path
  end
end

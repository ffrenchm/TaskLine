class TeamsController < ApplicationController
  before_action :find_team, except: [:index, :create]

  def index
    @user = current_user
    @teams = @user.teams
    @team = Team.new
  end

  def create
    @user = current_user
    @team = Team.new(team_params)
    if @team.save
      @user.join(@team)
      @membership = Membership.find_by(user_id: @user.id, team_id: @team.id)
      @membership.update(admin: true)
      redirect_to @team
    else
      flash[:danger] = "Make sure you include a team name."
    end
  end

  def show
    @invite = @team.invites.build
    @membership = Membership.find_by(user_id: current_user.id, team_id: @team.id)
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to teams_path
    end
  end

  def destroy
    @team.destroy
    redirect_to request.referrer || teams_path
  end

  private

    def team_params
      params.require(:team).permit(:name, :public)
    end

    def find_team
      @team = Team.find(params[:id])
    end
end

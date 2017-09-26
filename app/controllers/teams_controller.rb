class TeamsController < ApplicationController
  before_action :find_team, except: [:index, :create, :show]
  before_action :in_team, only: :edit

  def index
    @user = current_user
    @teams = @user.teams
    @public_teams = Team.except(current_user.teams).where(public: 1)
    @team = Team.new
  end

  def create
    @user = current_user
    @team = Team.new(team_params)
    if @team.save
      @user.join(@team)
      @membership = Membership.find_by(user_id: @user.id, team_id: @team.id)
      @membership.update(admin: true)
      redirect_to team_path(@team)
    end
  end

  def show
    @team = Team.find(params[:id])
    @invite = @team.invites.build
    @membership = Membership.find_by(user_id: current_user.id, team_id: @team.id)
    @tasks = @team.tasks
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
    redirect_to teams_path
  end

  private

    def team_params
      params.require(:team).permit(:name, :public)
    end

end

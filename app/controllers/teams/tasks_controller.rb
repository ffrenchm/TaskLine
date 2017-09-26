class Teams::TasksController < ApplicationController
  before_action :signed_in_user
  before_action :find_task_team
  before_action :in_team

  def new
    @task = @team.tasks.build
  end

  def create
    @user = current_user
    @task = @team.tasks.build(task_params)
    @task.user_id = @user.id
    unless @task.save
      flash[:danger] = "Invalid task"
    end
    redirect_to team_path(@team)
  end

  private

    def task_params
      params.require(:task).permit(:content, :deadline_date, :deadline_time, :repeat, :repeat_number, :repeat_period, :team_id, :notes)
    end

    def find_task_team
      @team = Team.find(params[:team_id])
    end

end

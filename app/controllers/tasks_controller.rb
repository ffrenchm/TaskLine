class TasksController < ApplicationController
  before_action :signed_in_user
  before_action :find_task
  before_action :task_permission

  def edit
  end

  def move_form
  end

  def update
    @task.update(task_params)
    redirect_to categories_path
  end

  def destroy
    if URI(request.referrer).path == "/teams/#{@task.team_id}"
      @task.destroy
      redirect_to request.referrer
    elsif @task.team_id == nil
      @task.destroy
    else
      @task.update(category_id: nil)
    end
  end

  def complete
    @task.update(completed: !@task.completed)
    if @task.repeat == 1 && @task.completed == true
      @new_task = @task.dup
      @new_task.update(deadline_date: @task.deadline_date + @task.increment, completed: false)
    end
  end

  private

    def task_params
      params.require(:task).permit(:content, :deadline_date, :deadline_time, :repeat, :repeat_number, :repeat_period, :category_id, :notes)
    end

    def task_permission
      unless @task.category && current_user.categories.include?(@task.category) || @task.team && current_user.teams.include?(@task.team)
        redirect_to request.referrer || root_path
      end
    end

end

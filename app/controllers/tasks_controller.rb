class TasksController < ApplicationController
  before_action :signed_in_user
  before_action :find_task

  def edit
    session[:return_to] = request.referrer
  end

  def move_form
    session[:return_to] = request.referrer
  end

  def update
    @task.update(task_params)
    redirect_to session[:return_to]
  end

  def destroy
    if @task.team_id == nil
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

    def find_task
      @task = Task.find(params[:id])
    end
end

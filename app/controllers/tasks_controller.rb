class TasksController < ApplicationController
  before_action :signed_in_user
  before_action :find_task, except: [:new, :create]

  def edit
    session[:return_to] = request.referrer
  end

  def update
    unless @task.update(task_params)
      flash[:danger] = "Invalid list task"
    end
    redirect_to session[:return_to]
  end

  def destroy
    if @task.team_id == nil
      @task.destroy
    else
      @task.category_id = nil
    end
  end

  def complete
    unless @task.update(completed: !@task.completed)
      flash[:danger] = "Error"
    end
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

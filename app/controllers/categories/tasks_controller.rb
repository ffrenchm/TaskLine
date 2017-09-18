class Categories::TasksController < ApplicationController
  before_action :signed_in_user
  before_action :find_category
  before_action :find_task, only: [:edit, :move_form, :update]

  def new
    @task = @category.tasks.build
  end

  def create
    @user = current_user
    @task = @category.tasks.build(task_params)
    @task.user_id = @user.id
    unless @task.save
      flash[:danger] = "Invalid task"
    end
    redirect_to categories_path
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to categories_path
  end

  def move_form
  end

  private

    def task_params
      params.require(:task).permit(:content, :deadline_date, :deadline_time, :repeat, :repeat_number, :repeat_period, :category_id, :notes)
    end

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_task
      @task = Task.find(params[:id])
    end
end

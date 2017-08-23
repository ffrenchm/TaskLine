class Categories::TasksController < ApplicationController
  before_action :signed_in_user
  before_action :find_category, except: [:complete]
  before_action :find_task, except: [:new, :create]
  before_action :verify_move, only: :update

  def new
    @task = @category.tasks.build
  end

  def create
    @user = current_user
    @task = @category.tasks.build(task_params)
    @task.user_id = @user.id
    unless @task.save
      flash[:danger] = "Invalid list task"
    end
    redirect_to categories_path
  end

  def edit
  end

  def update
    unless @task.update(task_params)
      flash[:danger] = "Invalid list task"
    end
    redirect_to categories_path
  end

  def destroy
    if @task.destroy
      redirect_to request.referrer || categories_path
    end
  end

  def complete
    unless @task.update(completed: !@task.completed)
      flash[:danger] = "Error"
    end
    redirect_to request.referrer || categories_path
  end

  private

    def task_params
      params.require(:task).permit(:content, :deadline_date, :deadline_time, :repeat, :category_id, :notes)
    end

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_task
      @task = Task.find(params[:id])
    end

    def verify_move
      if Category.find_by(id: params[:category_id]).user != current_user
        redirect_to categories_path
        flash[:danger] = "You can't move it to someone else's category BUD."
      end
    end
end

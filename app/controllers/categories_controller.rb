class CategoriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show]
  before_action :correct_user, except: [:index, :create]

  def index
    @user = current_user
    @categories = @user.categories
    @category = @user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)
    flash[:danger] = "Invalid category" unless @category.save
    redirect_to categories_path
  end

  def edit
  end

  def update
    unless @category.update(category_params)
      flash[:danger] = "Invalid name"
    end
    redirect_to categories_path
  end

  def destroy
    @category.destroy
    redirect_to request.referrer || categories_path
  end

  def show
    @items = @category.items
    @item = @category.items.build
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

    def correct_user
      @category = current_user.categories.find(params[:id])
      redirect_to categories_path if @category.nil?
    end

end

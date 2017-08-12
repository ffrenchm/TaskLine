class CategoriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show]
  before_action :correct_user, only: :destroy

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

  def destroy
    @category.destroy
    redirect_to request.referrer || categories_path
  end

  def show
    @user = current_user
    @category = current_user.categories.find(params[:id])
    @item = @category.items.build
    @items = @category.items
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

    def item_params
      params.require(:item).permit(:content)
    end

    def correct_user
      @category = current_user.categories.find_by(id: params[:id])
      redirect_to categories_path if @category.nil?
    end
end

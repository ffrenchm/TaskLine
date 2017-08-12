class ListCategoriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show]
  before_action :correct_user, only: :destroy

  def index
    @user = current_user
    @list_categories = @user.list_categories
    @list_category = @user.list_categories.build
  end

  def create
    @list_category = current_user.list_categories.build(list_category_params)
    flash[:danger] = "Invalid category" unless @list_category.save
    redirect_to list_categories_path
  end

  def destroy
    @list_category.destroy
    redirect_to request.referrer || list_categories_path
  end

  def show
    @user = current_user
    @list_category = current_user.list_categories.find(params[:id])
    @list_item = @list_category.list_items.build
    @list_items = @list_category.list_items
  end

  private

    def list_category_params
      params.require(:list_category).permit(:title)
    end

    def list_item_params
      params.require(:list_item).permit(:content)
    end

    def correct_user
      @list_category = current_user.list_categories.find_by(id: params[:id])
      redirect_to list_categories_path if @list_category.nil?
    end
end

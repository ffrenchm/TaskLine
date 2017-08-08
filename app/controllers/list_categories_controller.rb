class ListCategoriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index]
  before_action :correct_user, only: :destroy

  def index
    @user = current_user
    @list_categories = @user.list_categories
    @list_category = @user.list_categories.build
  end

  def create
    @list_category = current_user.list_categories.build(list_category_params)
    if @list_category.save
      redirect_to list_categories_path
    else
      flash[:danger] = "Invalid category"
    end
  end

  def destroy
    @list_category.destroy
    flash[:success] = "Category deleted"
    redirect_to request.referrer || list_categories_path
  end

  private

    def list_category_params
      params.require(:list_category).permit(:title)
    end

    def correct_user
      @list_category = current_user.list_categories.find_by(id: params[:id])
      redirect_to list_categories_path if @list_category.nil?
    end
end

class Categories::ItemsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @user = current_user
    @category = Category.find(params[:category_id])
    @item = Item.new(item_params)
    @item.category_id = @category.id
    @item.user_id = @user.id
    if @item.save
      redirect_to category_path(@category)
    else
      flash[:danger] = "Invalid list item"
      redirect_to categories_path
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to request.referrer || categories_path
    end
  end

  private

    def item_params
      params.require(:item).permit(:content, :deadline_date, :deadline_time, :repeat)
    end
end

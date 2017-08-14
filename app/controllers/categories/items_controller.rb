class Categories::ItemsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = current_user
    @category = Category.find(params[:category_id])
    @item = Item.new(item_params)
    @item.category_id = @category.id
    @item.user_id = @user.id
    unless @item.save
      flash[:danger] = "Invalid list item"
    end
    redirect_to @category
  end

  def edit
    @category = Category.find(params[:category_id])
    @item = Item.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @item = Item.find(params[:id])
    unless @item.update(item_params)
      flash[:danger] = "Invalid list item"
    end
    redirect_to @category
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

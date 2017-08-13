class ItemsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @user = current_user
    @category = current_user.categories.find(params[:item][:category_id])
    @item = @user.items.build(item_params)
    if @item.save
      redirect_to category_path(@category)
    else
      flash[:danger] = "Invalid list item"
      redirect_to categories_path
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    if @item.destroy
      redirect_to request.referrer || categories_path
    end
  end

  private

    def item_params
      params.require(:item).permit(:content, :deadline, :repeat)
    end
end

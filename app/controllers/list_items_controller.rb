class ListItemsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @user = current_user
    @list_category = current_user.list_categories.find_by(id: params[:list_item][:list_category_id])
    @list_item = @list_category.list_items.build(list_item_params)
    if @list_item.save
      redirect_to list_category_path(@list_category)
    else
      redirect_to list_categories
    end
  end

  def destroy
    @list_item = current_user.list_items.find(params[:id])
    if @list_item.destroy
      redirect_to request.referrer || list_categories_path
    end
  end

  private

    def list_item_params
      params.require(:list_item).permit(:content)
    end
end

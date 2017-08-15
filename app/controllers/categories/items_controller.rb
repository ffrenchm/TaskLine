class Categories::ItemsController < ApplicationController
  before_action :signed_in_user
  before_action :find_category, except: :complete
  before_action :find_item, except: [:create, :new]

  def new
    @new_item = @category.items.build
  end

  def create
    @user = current_user
    @item = Item.new(item_params)
    @item.category_id = @category.id
    @item.user_id = @user.id
    unless @item.save
      flash[:danger] = "Invalid list item"
    end
    redirect_to categories_path
  end

  def edit
  end

  def update
    unless @item.update(item_params)
      flash[:danger] = "Invalid list item"
    end
    redirect_to categories_path
  end

  def destroy
    if @item.destroy
      redirect_to request.referrer || categories_path
    end
  end

  def complete
    @category = @item.category
    unless @item.update(completed: !@item.completed)
      flash[:danger] = "Error"
    end
    redirect_to request.referrer || categories_path
  end

  private

    def item_params
      params.require(:item).permit(:content, :deadline_date, :deadline_time, :repeat)
    end

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_item
      @item = Item.find(params[:id])
    end
end

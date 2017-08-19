class Categories::ItemsController < ApplicationController
  before_action :signed_in_user
  before_action :find_category, except: [:complete, :move]
  before_action :find_item, except: [:new, :create]

  def new
    @item = @category.items.build
  end

  def create
    @user = current_user
    @item = @category.items.build(item_params)
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
    unless @item.update(completed: !@item.completed)
      flash[:danger] = "Error"
    end
    redirect_to request.referrer || categories_path
  end

  def move
    unless @item.update(category_id: @category.id)
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

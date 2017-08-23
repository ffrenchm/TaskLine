class Categories::ItemsController < ApplicationController
  before_action :signed_in_user
  before_action :find_category, except: [:complete]
  before_action :find_item, except: [:new, :create]
  before_action :verify_move, only: :update

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

  private

    def item_params
      params.require(:item).permit(:content, :deadline_date, :deadline_time, :repeat, :category_id, :notes)
    end

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_item
      @item = Item.find(params[:id])
    end

    def verify_move
      if Category.find_by(id: params[:category_id]).user != current_user
        redirect_to categories_path
        flash[:danger] = "You can't move it to someone else's category BUD."
      end
    end
end

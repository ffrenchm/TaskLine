class PagesController < ApplicationController
  def home
    @skip_title = true
    if signed_in?
      @items = current_user.items
      # @items_by_date = Item.group_by(&:deadline_date)
    else
      @user = User.new
      @skip_footer = true
    end
  end
end

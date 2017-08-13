class PagesController < ApplicationController
  def home
    if signed_in?
      @items = current_user.items
    else
      @user = User.new
    end
  end
end

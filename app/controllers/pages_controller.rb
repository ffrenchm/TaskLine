class PagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @list_categories = @user.list_categories
    else
      @user = User.new
    end
  end
end

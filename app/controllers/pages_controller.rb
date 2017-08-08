class PagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end
end

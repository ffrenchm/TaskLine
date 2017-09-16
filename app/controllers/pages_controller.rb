class PagesController < ApplicationController
  def calendar
    @skip_title = true
    if signed_in?
      @tasks = current_user.tasks
    else
      @user = User.new
      @skip_footer = true
    end
  end

  def inbox
    @user = current_user
  end
end

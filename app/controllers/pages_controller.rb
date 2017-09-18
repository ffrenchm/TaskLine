class PagesController < ApplicationController
  def calendar
    if signed_in?
      @tasks = current_user.tasks
    else
      @user = User.new
      @skip_footer = true
    end
  end
end

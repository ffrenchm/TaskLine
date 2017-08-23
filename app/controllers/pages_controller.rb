class PagesController < ApplicationController
  def home
    @skip_title = true
    if signed_in?
      @tasks = current_user.tasks
      # @tasks_by_date = Task.group_by(&:deadline_date)
    else
      @user = User.new
      @skip_footer = true
    end
  end
end

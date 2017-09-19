class PagesController < ApplicationController
  def calendar
    if signed_in?
      @tasks = current_user.tasks
    end
  end
end

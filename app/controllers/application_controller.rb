class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :signed_in_user
  include SessionsHelper

  private

    def find_task
      @task = Task.find(params[:id])
    end

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_team
      @team = Team.find(params[:id])
    end

    #confirms a signed in user
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path
      end
    end

end

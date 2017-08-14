class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    #confirms a signed in user
    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "Please sign in"
        redirect_to root_path
      end
    end

end

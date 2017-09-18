class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :back_url
  include SessionsHelper

  private

    def back_url
      unless request.referrer == request.original_url
        session[:referrer] = request.referrer
      end
    end

    #confirms a signed in user
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to calendar_path
      end
    end

end

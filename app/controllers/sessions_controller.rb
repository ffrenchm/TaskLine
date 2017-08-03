class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin user
      redirect_to root_path
    else
      flash[:danger] = "Invalid email/password"
      redirect_to root_path
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_url
  end
end

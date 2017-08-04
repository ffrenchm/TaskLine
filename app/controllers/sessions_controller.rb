class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin user
      remember user
      redirect_to root_path
    else
      flash[:danger] = "Invalid email/password"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end

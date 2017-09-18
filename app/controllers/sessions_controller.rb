class SessionsController < ApplicationController

  def new
    @user = User.new
    @skip_footer = true
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin user
      remember user
      redirect_back_or root_path
    else
      flash[:danger] = "Invalid email/password"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end

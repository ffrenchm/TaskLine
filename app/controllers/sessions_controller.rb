class SessionsController < ApplicationController
  skip_before_filter :signed_in_user

  def new
    @user = User.new
    @skip_footer = true
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin user
      remember user
      redirect_to root_path
    else
      flash[:danger] = "Invalid email/password"
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end

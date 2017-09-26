class UsersController < ApplicationController
  skip_before_action :signed_in_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  layout "minimal", only: :new

  def new
    @user = User.new
    @skip_footer = true
    @skip_title = true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      signin @user
      redirect_to edit_user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your details were updated."
    end
    redirect_to edit_user_path(current_user)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted successfully"
    sign_out
    redirect_to new_session_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end

    # before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end

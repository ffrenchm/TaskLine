class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
    @skip_footer = true
    @skip_title = true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if params[:user][:picture].present?
        render :crop
      else
        signin @user
        flash[:success] = "You signed up successfully."
        redirect_to edit_user_path(@user)
      end
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def crop
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      if params[:user][:picture].present?
        render :crop
      else
        redirect_to edit_user_path(@user)
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted successfully"
    sign_out
    redirect_to root_path
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

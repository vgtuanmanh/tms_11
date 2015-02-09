class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :is_admin_user

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "User has been added!"
      redirect_to admin_users_url
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "User's profile has been updated!"
      redirect_to admin_users_url
    else
      render 'edit'
    end
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end

  def is_admin_user
    redirect_to root_url unless admin_user?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
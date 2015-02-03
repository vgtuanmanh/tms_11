class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :is_admin_user

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
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
    redirect_to root_url unless current_user.admin?
  end
end
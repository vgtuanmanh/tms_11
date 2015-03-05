class Admin::ActivitiesController < ApplicationController
  before_action :logged_in_user

  def index
    @activities = current_user.activities
  end

  def show
    
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end
end

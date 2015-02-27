class Admin::AssignmentsController < ApplicationController
  before_action :is_admin_user
  before_action :set_course

  def new
    @assignment = @course.assignments.new
    @users = User.assignable(@course)
  end

  def index
    @users = @course.users
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end

  def is_admin_user
    redirect_to root_url unless admin_user?
  end
end
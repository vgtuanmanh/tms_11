class Admin::AssignmentsController < ApplicationController
  before_action :set_course
  def new
    @assignment = @course.assignments.new
    @users = User.assignable(@course) - User.is_admin
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end
end
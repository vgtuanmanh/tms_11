class Admin::AssignmentController < ApplicationController
  before_action :set_course

  def new
    @assignment = @course.assignments.new
    @users = User.all
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end
end
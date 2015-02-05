class Admin::CoursesController < ApplicationController
  def show
    @course = Course.find params[:id]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Create course successfully!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @courses = Course.all
  end

  private
  def course_params
    params.require(:course).permit(:name, :description, :begin_at, :end_at)
  end
end

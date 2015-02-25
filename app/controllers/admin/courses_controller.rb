class Admin::CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def show
    @course = Course.find params[:id]
    @users = @course.users
  end

  def update
    @course = Course.find params[:id]
    @course.update_attributes course_params
    @course.save
    @users = @course.users
    render :show
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Create course successfully!"
      redirect_to admin_courses_url
    else
      render 'new'
    end
  end

  private
  def course_params
    params.require(:course).permit(:name, :description, :begin_at, :end_at,
      user_ids: [], course_subjects_attributes: [:id, :subject_id, :_destroy])
  end
end

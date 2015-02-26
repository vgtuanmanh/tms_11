class Admin::CoursesController < ApplicationController

  def new
    @course = Course.new
    @subjects = Subject.all
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def show
    @course = Course.find params[:id]
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

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
      flash[:success] = "Course Updated"
      redirect_to admin_courses_path(@course)
    else
      render :edit
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Course deleted"
    redirect_to admin_courses_path
  end

  private
  def course_params
    params.require(:course).permit(:name, :description, :begin_at, :end_at,
                                   course_subjects_attributes: [:id, :subject_id,:_destroy])
  end
end

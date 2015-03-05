class Admin::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :is_admin_user, only: [:create, :destroy, :new]

  def new
    @course = Course.new
    @subjects = Subject.all
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def show
    @course = Course.find params[:id]
    @users = @course.users
    @subjects = @course.subjects
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
      flash[:success] = "Update successfully!"
      @users = @course.users
      redirect_to admin_course_path(@course)
    else
      redirect_to admin_courses_path
    end
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Create course successfully!"
      redirect_to admin_course_path(@course)
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find params[:id]
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Course deleted"
    redirect_to admin_courses_path
  end

  private
  def is_admin_user
    redirect_to root_url unless admin_user?
  end

  def course_params
    params.require(:course).permit(:name, :description, :begin_at, :end_at,
        user_ids:[], subject_ids:[],
        course_subjects_attributes: [:id, :subject_id, :_destroy])
  end

  def editable_course
    @course = Course.find params[:id]
    if !@course.begin_at.nil? || !@course.end_at.nil?
      flash[:success] = "Course is in training progress or finished! Cannot edit"
      redirect_to admin_course_path(@course)
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end
end

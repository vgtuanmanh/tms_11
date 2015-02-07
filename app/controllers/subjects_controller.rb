class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :check_admin_user, only: [:create, :destroy, :new]

  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find params[:id]
    @tasks = @subject.tasks.paginate(page: params[:page])
  end

  def new
    @subject = Subject.new
    task = @subject.tasks.build
  end

  def edit
  end

  def create
    @subject = Subject.new subject_params
    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_subject
    @subject = Subject.find params[:id]
  end

  def subject_params
    params.require(:subject).permit(:name, :description,
    tasks_attributes: [:name, :id, :_destroy])
  end

  def check_admin_user
    if !current_user || (current_user && !current_user.admin?)
      flash[:danger] = 'You are not'
      redirect_to root_path
    end
  end
end

class Assignment < ActiveRecord::Base
  before_save :default_values
  
  belongs_to :course
  belongs_to :user

  validates :user, presence: true
  validates :course, presence: true

  accepts_nested_attributes_for :user, allow_destroy: true

  before_save :rebuild_user_subjects

  private
  def rebuild_user_subjects
    course.subjects.each do |subject|
      user.user_subjects.find_or_create_by course_id: course.id, subject: subject
    end
  end

  def default_values
    self.status = 0 if self.status.nil?
  end
end

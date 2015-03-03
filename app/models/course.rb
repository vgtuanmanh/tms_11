class Course < ActiveRecord::Base

  has_many :course_subjects
  has_many :subjects, through: :course_subjects
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  validates :name,  presence: true, length: {maximum: 64}
  validates :description, presence: true, length: {maximum: 512}

  accepts_nested_attributes_for :course_subjects, allow_destroy: true

  def course_subject_id subject
    CourseSubject.where(course: self, subject: subject).first.try(:id)
  end
  
  accepts_nested_attributes_for :users, allow_destroy: true

  after_save :rebuild_assignment_data

  def rebuild_assignment_data
    if !self.begin_at.nil? && self.end_at.nil?
      self.assignments.update_all(status: 1)
    elsif !self.begin_at.nil? && !self.end_at.nil?
      self.assignments.update_all(status: 2)
    end
  end
end
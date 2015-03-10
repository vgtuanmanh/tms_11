class Course < ActiveRecord::Base
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  validates :name,  presence: true, length: {maximum: 64}
  validates :description, presence: true, length: {maximum: 512}

  accepts_nested_attributes_for :course_subjects, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: true

  def course_subject_id subject
    CourseSubject.where(course: self, subject: subject).first.try :id
  end

  after_save :rebuild_assignment_data, :rebuild_user_subjects

  def rebuild_assignment_data
    if self.begin_at.nil?
      self.assignments.update_all(status: 0)
    elsif self.end_at.nil?
      self.assignments.update_all(status: 1)
    else
      self.assignments.update_all(status: 2)
    end
  end

  def rebuild_user_subjects
    us1 = UserSubject.where course_id: id
    us2 = UserSubject.where course_id: id, user: users, subject: subjects
    us3 = us1 - us2
    UserSubject.destroy_all id: us3.map(&:id)
  end
end

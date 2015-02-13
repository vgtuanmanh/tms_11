class CourseUser < ActiveRecord::Base
  belongs_to :course, class_name: "Course"
  belongs_to :user, class_name: "User"
  validates :user, presence: true
  validates :course, presence: true
  accepts_nested_attributes_for :user, allow_destroy: true
end
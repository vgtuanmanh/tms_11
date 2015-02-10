class CourseSubject < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject
  default_scope -> {order(created_at: :desc)}
  accepts_nested_attributes_for :subject, allow_destroy: true
end
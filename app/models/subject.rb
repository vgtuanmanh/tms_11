class Subject < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  validates :name, presence: true, length: {maximum: 50}, uniqueness:true
  accepts_nested_attributes_for :tasks,
    reject_if: proc {|attributes| attributes[:name].blank?}, 
    allow_destroy: true
end
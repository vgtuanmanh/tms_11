class Subject < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}, uniqueness:true
  accepts_nested_attributes_for :tasks, reject_if: lambda {|attributes| attributes[:name].blank?}, 
                                        allow_destroy: true

  has_many :course_subjects
  has_many :courses, through: :course_subjects
end
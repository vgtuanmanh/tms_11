class Course < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 64 }
  validates :description, presence: true, length: { maximum: 512 }
  validates :begin_at, presence: true
  validates :end_at, presence: true

  validate :end_at_must_greater_than_or_equal_to_begin_at
  validate :begin_at_must_greater_than_or_equal_to_current_date

  has_many :course_subjects
  has_many :subjects, through: :course_subjects
  accepts_nested_attributes_for :course_subjects, allow_destroy: true

  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments
  accepts_nested_attributes_for :users, allow_destroy: true

  def end_at_must_greater_than_or_equal_to_begin_at
    if end_at < begin_at
      erros.add_to_base('End date must greater than or equal to Begin date!')   
    end
  end

  def begin_at_must_greater_than_or_equal_to_current_date
    if begin_at < Date.current
      erros.add_to_base('Begin date must greater than or equal to current date!')
    end
  end
end
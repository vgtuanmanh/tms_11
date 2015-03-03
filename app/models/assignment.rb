class Assignment < ActiveRecord::Base
  before_save :default_values
  belongs_to :course
  belongs_to :user

  validates :user, presence: true
  validates :course, presence: true

  accepts_nested_attributes_for :user, allow_destroy: true

  private
  def default_values
    self.status = 0 if self.status.nil?
  end
end

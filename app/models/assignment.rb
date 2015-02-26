class Assignment < ActiveRecord::Base
  before_save :default_values
  belongs_to :course
  belongs_to :user

  private
  def default_values
    self.status = 0 if self.status.nil?
  end
end

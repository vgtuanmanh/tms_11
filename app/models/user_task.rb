class UserTask < ActiveRecord::Base
	belongs_to :task
  belongs_to :user
  belongs_to :course

  validates :user, presence: true
  validates :task, presence: true
  validates :course, presence: true
end

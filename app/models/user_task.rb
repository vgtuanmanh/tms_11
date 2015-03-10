class UserTask < ActiveRecord::Base
	belongs_to :task
  belongs_to :user
  belongs_to :assignment

  validates :user, presence: true
  validates :task, presence: true
  validates :assignment, presence: true
end

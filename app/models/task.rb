class Task < ActiveRecord::Base
	has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks

  accepts_nested_attributes_for :users, allow_destroy: true

  belongs_to :subject
  default_scope ->{order(created_at: :asc)}
end

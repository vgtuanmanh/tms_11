class Task < ActiveRecord::Base
  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks
  
  belongs_to :subject
  default_scope ->{order(created_at: :desc)}
end

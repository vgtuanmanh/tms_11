class Subject < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects

  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  
  validates :name, presence: true, length: {maximum: 50}, uniqueness:true
  
  accepts_nested_attributes_for :tasks, reject_if: proc {|attributes| attributes[:name].blank?}, 
                                        allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: true

  after_save :assign_tasks_to_user
  after_save :assign_users_to_task

  def assign_tasks_to_user
    self.users.each do |user|
      user.update_attributes tasks: self.tasks
      user.save
    end
  end

  def assign_users_to_task
    self.tasks.each do |task|
      task.update_attributes users: self.users
      task.save
    end
  end
end

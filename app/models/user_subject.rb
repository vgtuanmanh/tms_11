class UserSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  belongs_to :course

  validates :user, presence: true
  validates :subject, presence: true
  validates :course, presence: true
end

class UserSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  validates :user, presence: true
  validates :subject, presence: true
end

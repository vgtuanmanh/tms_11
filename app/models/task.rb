class Task < ActiveRecord::Base
  belongs_to :subject
  default_scope -> {order(created_at: :desc)}
end

class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :course_id
      t.integer :user_id
      t.boolean :status

      t.timestamps
    end
    add_index :course_users, :course_id
    add_index :course_users, :user_id
    add_index :course_users, [:course_id, :user_id], unique: true
  end
end
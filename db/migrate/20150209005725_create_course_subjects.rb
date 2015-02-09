class CreateCourseSubjects < ActiveRecord::Migration
  def change
    create_table :course_subjects do |t|
      t.integer :course_id
      t.integer :subject_id

      t.timestamps null: false
    end
    add_index :course_subjects, :course_id
    add_index :course_subjects, :subject_id
    add_index :course_subjects, [:course_id, :subject_id], unique: true
  end
end

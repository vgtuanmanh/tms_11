class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end

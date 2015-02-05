class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.datetime :begin_at
      t.datetime :end_at

      t.timestamps
    end
  end
end

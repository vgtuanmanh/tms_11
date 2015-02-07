class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name
      t.references :subject, index:true
      t.timestamps null: false
    end
  end
    add_foreign_key :tasks, :subjects
end

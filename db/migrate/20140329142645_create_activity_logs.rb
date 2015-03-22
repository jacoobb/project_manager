class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :name
      t.integer :student_id
      t.integer :project_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end

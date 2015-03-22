class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.text :message
      t.integer :student_id
      t.integer :teacher_id
      t.integer :project_id

      t.timestamps
    end
  end
end


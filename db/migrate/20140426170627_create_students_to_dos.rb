class CreateStudentsToDos < ActiveRecord::Migration
  def change
    create_table :students_to_dos do |t|
      t.belongs_to :student
      t.belongs_to :to_do
    end
  end
end

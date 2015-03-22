class CreateStudentsAndSubjects < ActiveRecord::Migration
  def change
    create_table :students_subjects do |t|
      t.belongs_to :student
      t.belongs_to :subject
    end
  end
end

class CreateProjectsTeachers < ActiveRecord::Migration
  def change
    create_table :projects_teachers do |t|
      t.belongs_to :project
      t.belongs_to :teacher
    end
  end
end

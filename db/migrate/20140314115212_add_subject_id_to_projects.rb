class AddSubjectIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :subject_id, :integer
  end
end

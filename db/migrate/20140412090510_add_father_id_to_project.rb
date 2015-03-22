class AddFatherIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :father_id, :integer
  end
end

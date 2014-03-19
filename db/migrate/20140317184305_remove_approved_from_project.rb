class RemoveApprovedFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :approved
  end
end

class AddApprovalStatusToProject < ActiveRecord::Migration
  def change
    add_column :projects, :approval_status, :string
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_type
      t.text :text
      t.integer :project_id

      t.timestamps
    end
  end
end

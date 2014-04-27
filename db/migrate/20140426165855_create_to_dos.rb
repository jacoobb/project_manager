class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.string :name
      t.boolean :done
      t.text :description
      t.integer :project_id

      t.timestamps
    end
  end
end

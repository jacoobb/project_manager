class CreateProjectsTechnologies < ActiveRecord::Migration
  def change
    create_table :projects_technologies do |t|
      t.belongs_to :technology
      t.belongs_to :project
    end
  end
end

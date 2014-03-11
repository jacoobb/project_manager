class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :academic_title

      t.timestamps
    end
  end
end

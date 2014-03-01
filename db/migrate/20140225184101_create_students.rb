class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :matricula_number
      t.string :pesel
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end

class CreateCreateChatsStudents < ActiveRecord::Migration
  def change
    create_table :chats_students do |t|
      t.belongs_to :chat
      t.belongs_to :student
    end
  end
end

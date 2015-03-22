class CreateCreateChatsTeachers < ActiveRecord::Migration
  def change
    create_table :chats_teachers do |t|
      t.belongs_to :chat
      t.belongs_to :teacher
    end
  end
end

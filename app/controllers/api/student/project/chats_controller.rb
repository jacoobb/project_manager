class Api::Student::Project::ChatsController < Api::Student::ProjectController

  def index
    @chats = current_project.chats.by_student current_student
  end
  
  def create
    result = Chat::MessageCreator.new(current_student,
              current_project, params_chats).create_by_student
    result ? head(201) : head(400)
  end


  private
    def params_chats
      params.require(:chats).permit :message, student_recipient_ids: [],
        teacher_recipient_ids: []
    end
end
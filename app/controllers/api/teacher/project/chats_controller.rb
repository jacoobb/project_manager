class Api::Teacher::Project::ChatsController < Api::Teacher::ProjectController

  def index
    @chats = current_project.chats.by_teacher current_teacher
  end
  
  def create
    result = Chat::MessageCreator.new(current_teacher,
              current_project, params_chats).create_by_teacher
    result ? head(201) : head(400)
  end


  private
    def params_chats
      params.require(:chats).permit :message, student_recipient_ids: [],
        teacher_recipient_ids: []
    end
end
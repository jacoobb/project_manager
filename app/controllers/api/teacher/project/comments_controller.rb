class Api::Teacher::Project::CommentsController < Api::Teacher::ProjectController
  
  def create
    if Project::CommentCreator.new(current_project, params_comments).create
      MyLogger.new.project_activity_log current_project, current_teacher, 'add_comment'
      head 201
    else
      head 400
    end
  end
  

  private
    def params_comments
      params.require(:comments).permit name: [:text], description: [:text]
    end
end
class Api::Teacher::ProjectController < Api::TeacherController
  before_action :current_project?
  

  private
    def current_project?
      current_project
      unless @current_project
        head 404
      end
    end

    def current_project
      @current_project = current_teacher.projects.find_by id: params[:project_id]
    end
end
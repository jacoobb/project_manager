class Api::Student::ProjectController < Api::StudentController
  before_action :current_project?
  

  private
    def current_project?
      current_project
      unless @current_project
        head 404
      end
    end

    def current_project
      @current_project = current_student.projects.find_by id: params[:project_id]
    end
end
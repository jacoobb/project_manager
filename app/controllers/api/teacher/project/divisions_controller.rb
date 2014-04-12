class Api::Teacher::Project::DivisionsController < Api::Teacher::ProjectController
  def create
    status = Project::Divider.new(current_project, params_divisions[:projects]).divide
    if status
      MyLogger.new.project_activity_log current_project, current_teacher, 'divide'
      head 201
    else
      head 404
    end
  end


  private
    def params_divisions
      params.require(:divisions).permit projects: [:name, :description]
    end
end
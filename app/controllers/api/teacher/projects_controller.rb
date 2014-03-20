class Api::Teacher::ProjectsController < Api::StudentController
  def index
    @projects = current_teacher.projects
  end

  def create
    
  end

  private

    def params_project_proposal
      params.require(:project_proposal).permit :category_id, :technology_id,
        :subject_id, project: [:name, :description, :project_type]
    end
end
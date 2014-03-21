class Api::Teacher::ProjectsController < Api::TeacherController
  def index
    @projects = current_teacher.projects
  end

  def create
    project_proposal = Project::ProjectProposalCreator.new(params_project_proposal, current_teacher)
    if project_proposal.create_by_teacher
      message = {id: project_proposal.project.id}
      render json: message.to_json, status: 201
    else
      render json: project_proposal.project.errors.to_json, status: 400
    end
  end

  private

    def params_project_proposal
      params.require(:project_proposal).permit :category_id, :technology_id,
        :subject_id, project: [:name, :description, :project_type]
    end
end
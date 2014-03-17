class Api::Student::ProjectsController < ApiController
  def index
    @projects = current_student.projects
  end
  
  def create
    project_proposal = Project::ProjectProposalCreator.new(params_project_proposal, current_student)
    if project_proposal.create
      message = {id: project_proposal.project.id}
      render json: message.to_json, status: 201
    else
      render json: project_proposal.project.errors.to_json, status: 400
    end
  end


  private

    def params_project_proposal
      params.require(:project_proposal).permit :teacher_id, :subject_id, project: [:name, :description, :project_type]
    end
end
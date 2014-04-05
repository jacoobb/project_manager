class Api::Teacher::ProjectsController < Api::TeacherController
  def index
    case params[:project_type]
    when 'subject'
      @projects = current_teacher.projects.subject
    when 'diploma'
      @projects = current_teacher.projects.diploma
    when 'first_degree'
      @projects = current_teacher.projects.first_degree
    when 'second_degree'
      @projects = current_teacher.projects.second_degree
    end
  end

  def show
    @project = current_teacher.projects.find_by id: params[:id]
  end

  def update
    project = current_teacher.projects.find params[:id]
    project.approval_status = 'approved'
    if project.update params_project_proposal[:project]
      head 201
    else
      head 400
    end
  end

  def create
    project_proposal = Project::ProjectProposalCreator.new(params_project_proposal, current_teacher)
    if project_proposal.create_by_teacher
      MyLogger.new.project_activity_log project_proposal.project, current_teacher, 'create_project_proposal'
      message = {id: project_proposal.project.id}
      render json: message.to_json, status: 201
    else
      render json: project_proposal.project.errors.to_json, status: 400
    end
  end

  private

    def params_project_proposal
      params.require(:project_proposal).permit :subject_id, project: [:name, :description, :project_type], category_ids: [], technology_ids: []
    end
end
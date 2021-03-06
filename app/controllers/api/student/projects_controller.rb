class Api::Student::ProjectsController < Api::StudentController
  def index
    case params[:project_type]
    when 'subject'
      @projects = current_student.projects.subject
    when 'diploma'
      @projects = current_student.projects.diploma
    when 'first_degree'
      @projects = current_student.projects.first_degree
    when 'second_degree'
      @projects = current_student.projects.second_degree
    end
  end

  def show
    @project = current_student.projects.find_by id: params[:id]
  end

  def update
    project = current_student.projects.find params[:id]
    project.approval_status = 'expectant'
    if project.update params_project_proposal[:project]
      MyLogger.new.project_activity_log project, current_student, 'update_project_proposal'
      head 201
    else
      head 400
    end
  end
  
  def create
    project_proposal = ::Project::ProjectProposalCreator.new(params_project_proposal, current_student)
    if project_proposal.create_by_student
      MyLogger.new.project_activity_log project_proposal.project, current_student, 'create_project_proposal'
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
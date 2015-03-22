class Api::SubjectProjectsController < ApiController
  def index
    subject = Subject.find_by id: params_project[:id]
    @projects = subject.projects.approved
  end

  private

    def params_project
      params.require(:subject).permit :id
    end
end
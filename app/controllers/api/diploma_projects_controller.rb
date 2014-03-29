class Api::DiplomaProjectsController < ApiController
  def index
    # todo k paginacja
    @projects = Project.diploma.approved
  end
end
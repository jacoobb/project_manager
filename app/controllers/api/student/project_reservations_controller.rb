class Api::Student::ProjectReservationsController < Api::StudentController
  def create
    project = Project.find_by id: params_project_reservation[:id]
    if project
      project.reserve(current_student) ? head(201) : head(406)
    else
      head 404
    end
  end

  
  private

    def params_project_reservation
      params.require(:project_reservation).permit :id
    end
end
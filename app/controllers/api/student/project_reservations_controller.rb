class Api::Student::ProjectReservationsController < Api::StudentController
  def create
    project = Project.find_by id: params_project_reservation[:id]
    if project
      if project.reserve(current_student)
        MyLogger.new.project_activity_log project, current_student, 'reserve_project'
        head(201) 
      else
        head(406)
      end
    else
      head 404
    end
  end

  
  private

    def params_project_reservation
      params.require(:project_reservation).permit :id
    end
end
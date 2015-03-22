class Api::Student::Project::TeamMembersController < Api::Student::ProjectController
  def create
    members = find_members 
    if members
      current_project.add_students_to_team members
      MyLogger.new.project_activity_log current_project, current_student, 'add_student_to_team'
      head 201
    else
      head 406
    end
  end


  private 

    def find_members
      params_team_members[:ids].map do |id| 
        student = Student.find_by id: id 
        return false unless student
        student
      end
    end

    def params_team_members
      params.require(:team_members).permit ids: []
    end
end

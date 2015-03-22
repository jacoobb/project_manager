class Api::Student::ActivityLogsController < Api::StudentController
  def index
    @logs = ActivityLog.witch_student current_student
  end
end
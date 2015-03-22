class Api::Teacher::ActivityLogsController < Api::TeacherController
  def index
    @logs = ActivityLog.witch_teacher current_teacher
  end
end
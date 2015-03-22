class Api::Teacher::SubjectsController < Api::TeacherController
  def index
    @subjects = current_teacher.subjects
  end
end
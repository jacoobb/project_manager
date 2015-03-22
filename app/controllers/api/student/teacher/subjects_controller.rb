class Api::Student::Teacher::SubjectsController < Api::StudentController
  def index
    teacher = ::Teacher.find_by_id params[:teacher_id]
    if teacher
      @subjects = teacher.subjects
    else
      head 404, text: 'Teacher not found'
    end
  end
end
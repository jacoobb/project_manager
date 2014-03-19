class Api::Student::StudentsController < Api::StudentController
  def show
    @student = current_student
  end

end
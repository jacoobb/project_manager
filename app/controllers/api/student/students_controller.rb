class Api::Student::StudentsController < ApiController
  def show
    @student = current_student
    head 404 unless @student
  end

end
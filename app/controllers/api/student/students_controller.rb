class Api::Student::StudentsController < ApiController

  def show
    @student = ::Student.find_by matricula_number: params[:id] 
    head 404 unless @student
    
  end

end
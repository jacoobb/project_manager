class Api::Student::SessionController < Api::StudentController
  skip_before_action :require_login, only: [:create]
  
  def create
    student = ::Student.authenticate params_student[:matricula_number], params_student[:password]
    if student
      session[:student_id] = student.id
      render json: {matricula_number: student.matricula_number}.to_json, status: 201
    else
      head 401
    end
  end

  def destroy
    session[:student_id] = nil
    head 201
  end


  private

    def params_student
      params.require(:student).permit :matricula_number, :password
    end
end
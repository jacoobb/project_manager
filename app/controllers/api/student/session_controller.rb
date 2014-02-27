class Api::Student::SessionController < ApiController
  
  def index
    #todo
    students = ::Student.all
    render json: students.to_json, status: 201
  end

  def create
    student = ::Student.authenticate params_student[:student_id], params_student[:password]
    if student
      session[:student_id] = student.id
      head 201
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
      params.require(:student).permit :student_id, :password
    end
end
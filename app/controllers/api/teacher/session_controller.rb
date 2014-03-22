class Api::Teacher::SessionController < Api::TeacherController
  skip_before_action :require_login, only: [:create]
    
  def create
    teacher = ::Teacher.authenticate params_teacher[:email], params_teacher[:password]
    if teacher
      session[:teacher_id] = teacher.id
      json = {
        id: teacher.id,
        first_name: teacher.first_name,
        last_name: teacher.last_name,
        academic_title: teacher.academic_title
      }.to_json
      render json: json, status: 201
    else
      head 401
    end
  end

  def destroy
    session[:teacher_id] = nil
    head 201
  end


  private

    def params_teacher
      params.require(:teacher).permit :email, :password
    end
end
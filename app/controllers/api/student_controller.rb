class Api::StudentController < ApiController
  before_action :require_login
  
  private

    def require_login
      unless logged_in?
        head 401
      end
    end

    def current_student
      @current_student ||= ::Student.find(session[:student_id]) if session[:student_id]
    end
    
    def logged_in?
      !!current_student
    end
end
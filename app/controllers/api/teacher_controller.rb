class Api::TeacherController < ApiController
  before_action :require_login

  private
    def require_login
      unless logged_in?
        head 401
      end
    end

    def current_teacher
      @current_teacher ||= ::Teacher.find(session[:teacher_id]) if session[:teacher_id]
    end

    def logged_in?
      !!current_teacher
    end
end
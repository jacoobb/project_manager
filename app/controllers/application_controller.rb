class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #todo
  # protect_from_forgery with: :null_session
  # before_filter :cors_set_access_control_headers

  helper_method :current_user
  

  private

    def current_student
      @current_student ||= ::Student.find(session[:student_id]) if session[:student_id]
    end

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Headers'] = 'X-AUTH-TOKEN, X-API-VERSION, X-Requested-With, Content-Type, Accept, Origin'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Max-Age'] = "1728000"
    end
end

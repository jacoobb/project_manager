class Api::Student::TeachersController < ApiController
  def index
    @teachers = ::Teacher.all
  end
end
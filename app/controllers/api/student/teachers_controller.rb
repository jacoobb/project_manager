class Api::Student::TeachersController < Api::StudentController
  def index
    # todo k czy wszystkie czy studenta?
    @teachers = ::Teacher.all
  end
end
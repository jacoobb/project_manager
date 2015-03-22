class Api::Student::SubjectsController < Api::StudentController
  def index
    # todo k czy wszystkie czy studenta?
    @subjects = ::Subject.all
  end
end
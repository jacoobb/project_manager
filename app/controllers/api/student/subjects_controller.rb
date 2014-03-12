class Api::Student::SubjectsController < ApiController
  def index
    @subjects = ::Subject.all
  end
end
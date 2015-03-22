class Api::StudentsController < ApiController
  def index
    @students = ::Student.all
  end
end
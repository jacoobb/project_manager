class Api::TechnologiesController < ApiController
  def index
    @technologies = Technology.all
  end
end
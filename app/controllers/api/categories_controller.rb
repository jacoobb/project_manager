class Api::CategoriesController < ApiController
  def index
    @categories = Category.all
  end
end
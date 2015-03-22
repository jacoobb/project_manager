require 'spec_helper'

describe Api::CategoriesController do
  let(:category) { FactoryGirl.create :category } 

  describe '#get index' do

    it 'return categories' do
      category.reload
      get :index, format: :json
      JSON.parse(response.body).first["id"].should eq category.id
    end
  end
end
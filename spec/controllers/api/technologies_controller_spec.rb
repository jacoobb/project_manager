require 'spec_helper'

describe Api::TechnologiesController do
  let(:technology) { FactoryGirl.create :technology } 

  describe '#get index' do

    it 'return categories' do
      technology.reload
      get :index, format: :json
      JSON.parse(response.body).first["id"].should eq technology.id
    end
  end
end
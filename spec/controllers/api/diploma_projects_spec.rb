require 'spec_helper'

describe Api::DiplomaProjectsController do
  let!(:subject_project) { FactoryGirl.create :subject_project }
  let!(:first_degree) { FactoryGirl.create :project }
  let!(:second_degree) { FactoryGirl.create :project }

  describe '#GET index' do
    before {get :index, format: :json}

    it '200 code' do
      response.code.should eq '200' 
    end

    it do 
      JSON.parse(response.body).count.should eq 2
    end

  end
end
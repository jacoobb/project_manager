require 'spec_helper'

describe Api::SubjectProjectsController do
  let!(:subject) { FactoryGirl.create :subject }
  let!(:project) { FactoryGirl.create :project, project_type: 'subject', subject: subject}

  describe '#GET index' do
    before do
      get :index, format: :json, subject: {id: subject.id}
    end

    it '200 code' do
      response.code.should eq '200' 
    end

    it do 
      JSON.parse(response.body).count.should eq 1
    end
  end
end
require 'spec_helper'

describe Api::Student::ProjectReservationsController do
  let(:project) { FactoryGirl.create :project }
  let(:student) { FactoryGirl.create :student}
  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end

  describe '#POST create' do
    it 'bad id' do
      post :create, project_reservation: {id: 1}
      response.status.should eq 404
    end

    it 'success' do 
      post :create, project_reservation: {id: project.id}
      response.status.should eq 201
    end

    it 'projec is reserved' do
      post :create, project_reservation: {id: project.id}
      post :create, project_reservation: {id: project.id}
      response.status.should eq 406
    end
  end
end
require 'spec_helper'

describe Api::Student::Project::TeamMembersController do
  let(:project) { FactoryGirl.create :project }
  let(:student) { FactoryGirl.create :student}
  let(:member1) { FactoryGirl.create :student}
  let(:member2) { FactoryGirl.create :student}
  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end

  describe 'current_project' do
    it 'empty' do
      post :create, team_members: {ids: [member1.id,member2.id]}
      response.status.should eq 404
    end
  end
  
  describe '#POST create' do
    describe 'success' do
      before do 
        student.projects << project
        post :create, {
          project_id: project.id,
          team_members: {ids: [member1.id,member2.id]}
        }
      end

      it 'status 201' do 
        response.status.should eq 201
      end

      it 'project have 3 members' do
        project.students.count.should eq 3
      end
    end

    it 'bad members ids' do 
      student.projects << project
      post :create, {
        project_id: project.id,
        team_members: {ids: [member1.id,1]}
      }
      response.status.should eq 406  
    end
  end
end
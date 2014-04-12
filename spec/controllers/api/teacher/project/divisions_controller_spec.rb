require 'spec_helper'

describe Api::Teacher::Project::DivisionsController do
  let(:project) { FactoryGirl.create :project }
  let(:teacher) { FactoryGirl.create :teacher }
  
  before do
    teacher.projects << project
    Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
  end

  describe '#POST create' do
    describe 'success' do
      before do
        post :create, {
          project_id: project.id,
          divisions:{
            projects: [
              {name: "podzial 1", description: 'frontend'},
              {name: "podzial 2", description: 'backend'},
              {name: "podzial 3", description: 'DB'}
            ]
          }
        }
      end

      it 'status' do
        response.status.should eq 201
      end

      it 'create tree project' do
        Project.count.should eq 4
      end
    end

    describe 'error' do
      before do
        post :create, {
          project_id: project.id,
          divisions:{
            projects: [
              {name: "podzial 1", description: 'frontend'},
              {name: "podzial 2", description: 'backend'},
              {name: "podzial 3", description: ''}
            ]
          }
        }
      end

      it 'status' do
        response.status.should eq 404
      end
    end
  end
end
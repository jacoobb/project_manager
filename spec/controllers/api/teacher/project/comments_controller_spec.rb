require 'spec_helper'

describe Api::Teacher::Project::CommentsController do
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
          comments:{
            name: {text: 'temat nie na temat'},
            description: {text: 'opis malo szczegolowy'}
          }
        }
      end

      it 'status' do
        response.status.should eq 201
      end
    end

    describe 'error' do
      before do
        post :create, {
          project_id: project.id,
          comments:{
            name: {text: 'temat nie na temat'},
            description: {text: ''}
          }
        }
      end

      it 'status' do
        response.status.should eq 400
      end
    end
  end
end
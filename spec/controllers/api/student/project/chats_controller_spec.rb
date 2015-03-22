require 'spec_helper'

describe Api::Student::Project::ChatsController do
  let(:project) { FactoryGirl.create :project}
  let(:teacher) { FactoryGirl.create :teacher }
  let(:student) { FactoryGirl.create :student }
  let(:student2) { FactoryGirl.create :student }

  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end

  describe 'current_project' do
    it 'empty' do
      post :create
      response.status.should eq 404
    end
  end

  describe '#POST create' do
    describe 'success' do
      before do 
        student.projects << project

        post :create, {
          project_id: project.id,
          chats: {
            message: 'nie damy rady!!',
            student_recipient_ids: [student2.id],
            teacher_recipient_ids: [teacher.id]
          }
        }
      end

      it 'status 201' do 
        response.status.should eq 201
      end
    end

    describe 'error' do
      before do 
        student.projects << project

        post :create, {
          project_id: project.id,
          chats: {
            student_recipient_ids: [student2.id],
            teacher_recipient_ids: [teacher.id]
          }
        }
      end

      it 'status 400' do 
        response.status.should eq 400
      end
    end
  end

  describe '#GET index' do
    let(:teacher) { FactoryGirl.create :teacher }
    let(:student) { FactoryGirl.create :student }
    let(:student2) { FactoryGirl.create :student }
    let(:project) { FactoryGirl.create :project }

    before do 
      student.projects << project
      atr = {
        message: 'nie damy rady!!',
        student_recipient_ids: [student2.id],
        teacher_recipient_ids: [teacher.id]
      }
      Chat::MessageCreator.new(student, project, atr).create_by_student

      atr = {
        message: 'nie damy rady!!',
        student_recipient_ids: [student2.id],
        teacher_recipient_ids: [teacher.id]
      }
      Chat::MessageCreator.new(student2, project, atr).create_by_student
      get :index, format: :json, project_id: project.id
    end

    it 'status' do 
      response.status.should eq 200
    end
    
    it 'return projects' do
      JSON.parse(response.body).count.should eq 1
    end
  end
end
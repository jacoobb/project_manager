require 'spec_helper'

describe Api::Student::ProjectsController do
  let(:teacher) { FactoryGirl.create :teacher}
  let(:subject) { FactoryGirl.create :subject}

  let(:student) { FactoryGirl.create :student}
  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end

  describe '#post create' do 
    describe 'add project of subject' do
      describe 'success' do

        before do
          post :create, project_proposal:{
            project:{
              name: 'Aplikacja na platformę Android',
              description: 'Praca polega na napisaniu aplikacja na androida',
              project_type: 'subject'
            },
            teacher_id: teacher.id,
            subject_id: subject.id
          }
        end

        it 'return 201' do
          response.status.should eq 201
        end

        it 'create description' do
          Project.last.name.should eq 'Aplikacja na platformę Android'
        end

        it 'create associate with teacher' do
          Project.last.teachers.last.id.should eq teacher.id
        end
        
        it 'create associate with subject' do
          Project.last.subject.id.should eq subject.id
        end

        it 'create associate with student' do
          Project.last.students.last.id.should eq student.id
        end

        it 'return project id' do
          JSON.parse(response.body)['id'].should eq Project.last.id
        end

      end

      describe 'failure' do
        before do
          post :create, project_proposal:{
            project:{
              name: '',
              description: 'Praca polega na napisaniu aplikacja na androida',
              project_type: 'subject'
            },
            teacher_id: teacher.id,
            subject_id: subject.id
          }        
        end
        it 'name is empty' do
          JSON.parse(response.body)["name"].should_not be_empty
        end

        it 'name is empty' do
          response.status.should eq 400
        end
      end
    end
  end

  describe '#GET index' do
    describe 'subject project_type' do
      before do
        post :create, project_proposal:{
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'subject'
          },
          teacher_id: teacher.id,
          subject_id: subject.id
        }
      end

      it 'return project' do
        get :index, format: :json
        JSON.parse(response.body).first["id"].should eq Project.last.id
      end

      it 'return subject' do
        get :index, format: :json
        JSON.parse(response.body).first["subject"].should_not be_empty
      end

      it 'return teachers' do
        get :index, format: :json
        JSON.parse(response.body).first["teachers"].should_not be_empty
      end

      it 'return members' do
        get :index, format: :json
        JSON.parse(response.body).first["members"].should_not be_empty
      end
    end

    describe 'first_degree project_type' do
      before do
        post :create, project_proposal:{
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'first_degree'
          },
          teacher_id: teacher.id
        }
      end
      it 'return project' do
        get :index, format: :json
        JSON.parse(response.body).first["id"].should eq Project.last.id
      end
    end
  end
end


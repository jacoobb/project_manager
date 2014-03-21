require 'spec_helper'

describe Api::Teacher::ProjectsController do
  let(:teacher) { FactoryGirl.create :teacher}
  let!(:subject) { FactoryGirl.create :subject}
  let!(:category) { FactoryGirl.create :category }
  let!(:technology) { FactoryGirl.create :technology }

  describe '#post create' do 

    it 'must be login' do 
      post :create, project_proposal:{
        project:{
          name: 'Aplikacja na platformę Android',
          description: 'Praca polega na napisaniu aplikacja na androida',
          project_type: 'subject'
        },
        category_id: category.id,
        technology_id: technology.id,
        subject_id: subject.id
      }
      response.status.should eq 401
    end

    describe 'success' do
      before do 
        Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
        post :create, project_proposal:{
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'subject'
          },
          category_id: category.id,
          technology_id: technology.id,
          subject_id: subject.id
        }
      end

      it 'return 201' do
        response.status.should eq 201
      end

      it 'create name' do
        Project.last.name.should eq 'Aplikacja na platformę Android'
      end

      it 'create associate with teacher' do
        Project.last.teachers.last.id.should eq teacher.id
      end

      it 'create associate with technology' do
        Project.last.technologies.last.id.should eq technology.id
      end

      it 'create associate with category' do
        Project.last.categories.last.id.should eq category.id
      end
      
      it 'create associate with subject' do
        Project.last.subject.id.should eq subject.id
      end

      it 'return project id' do
        JSON.parse(response.body)['id'].should eq Project.last.id
      end
    end

    describe 'failure' do
      before do 
        Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
        post :create, project_proposal:{
          project:{
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'subject'
          },
          technology_id: technology.id,
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

  describe '#GET index' do
    describe 'subject project_type' do
      before do 
        Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
        post :create, project_proposal:{
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'subject'
          },
          category_id: category.id,
          technology_id: technology.id,
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

      it 'return categories' do
        get :index, format: :json
        JSON.parse(response.body).first["categories"].should_not be_empty
      end

      it 'return technologies' do
        get :index, format: :json
        JSON.parse(response.body).first["technologies"].should_not be_empty
      end
    end
    describe 'first_degree project_type' do
      before do 
        Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
        post :create, project_proposal:{
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'first_degree'
          },
          category_id: category.id,
          technology_id: technology.id
        }
      end

      it 'return project' do
        get :index, format: :json
        JSON.parse(response.body).first["id"].should eq Project.last.id
      end
    end
  end
end
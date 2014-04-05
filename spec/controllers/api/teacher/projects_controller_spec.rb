require 'spec_helper'

describe Api::Teacher::ProjectsController do
  let(:teacher) { FactoryGirl.create :teacher}
  let!(:subject) { FactoryGirl.create :subject}
  let!(:category) { FactoryGirl.create :category }
  let!(:category_2) { FactoryGirl.create :category }
  let!(:technology) { FactoryGirl.create :technology }
  let!(:technology_2) { FactoryGirl.create :technology }

  describe '#post create' do 

    it 'must be login' do 
      post :create, project_proposal:{
        project:{
          name: 'Aplikacja na platformę Android',
          description: 'Praca polega na napisaniu aplikacja na androida',
          project_type: 'subject'
        },
        category_ids: [category.id, category_2.id],
        technology_ids: [technology.id, technology_2.id],
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
          category_ids: [category.id, category_2.id],
          technology_ids: [technology.id, technology_2.id],
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
        Project.last.technologies.count.should eq 2
      end

      it 'create associate with category' do
        Project.last.categories.count.should eq 2
      end
      
      it 'create associate with subject' do
        Project.last.subject.id.should eq subject.id
      end

      it 'create associate with students' do
        Project.last.students.count.should eq 0
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
          technology_ids: [technology.id, technology_2.id],
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

    let(:subject_project) {FactoryGirl.create :subject_project}
    let(:first_degree) {FactoryGirl.create :diploma_project, project_type: 'first_degree'}
    let(:second_degree) {FactoryGirl.create :diploma_project, project_type: 'second_degree'}
    before do 
      Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
      first_degree.teachers << teacher
      second_degree.teachers << teacher
      subject_project.teachers << teacher
      first_degree.categories << category
      second_degree.categories << category
      subject_project.categories << category
      first_degree.technologies << technology
      second_degree.technologies << technology
      subject_project.technologies << technology
    end

    describe 'subject project_type' do
      it 'return 1 project' do
        get :index, format: :json, project_type: 'subject'
        JSON.parse(response.body).count.should eq 1
      end

      it 'return project' do
        get :index, format: :json, project_type: 'subject'
        JSON.parse(response.body).first["id"].should eq subject_project.id
      end

      it 'return subject' do
        get :index, format: :json, project_type: 'subject'
        JSON.parse(response.body).first["subject"].should_not be_empty
      end

      it 'return teachers' do
        get :index, format: :json, project_type: 'subject'
        JSON.parse(response.body).first["teachers"].should_not be_empty
      end

      it 'return members' do
        get :index, format: :json, project_type: 'subject'
        JSON.parse(response.body).first["members"].should be_empty
      end
    end

    describe 'diploma' do
      it 'return project' do
        get :index, format: :json, project_type: 'diploma'
        JSON.parse(response.body).count.should eq 2
      end
    end

    describe 'first_degree' do
      it 'return project' do
        get :index, format: :json, project_type: 'first_degree'
        JSON.parse(response.body).count.should eq 1
      end
    end

    describe 'second_degree' do
      it 'return project' do
        get :index, format: :json, project_type: 'second_degree'
        JSON.parse(response.body).count.should eq 1
      end
    end
  end

  describe '#GET show' do
    before {Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher}
    let(:project) { FactoryGirl.create :project }
    before do 
      teacher.projects << project 
      get :show, format: :json, id: project.id
    end

    it '200' do
      response.status.should eq 200
    end

    it 'return project' do
      JSON.parse(response.body)["id"].should eq project.id
    end
  end

  describe 'PUT update' do
    describe 'success' do
      let(:project) { FactoryGirl.create :project, approval_status: 'to_improve' }
      before do 
        Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
        teacher.projects << project 
        put :update, {
          id: project.id,
          project_proposal:{
            project:{
              name: 'Aplikacja na platformę Android poprawa tematu',
              description: 'Praca polega na napisaniu aplikacja na androida toprawa opisu'
            }
          }
        }
      end

      it '201' do
        response.status.should eq 201
      end

      it 'update name' do
        project.reload
        project.name.should eq 'Aplikacja na platformę Android poprawa tematu'
      end

      it 'update description' do
        project.reload
        project.description.should eq 'Praca polega na napisaniu aplikacja na androida toprawa opisu'
      end

      it 'update approval_status' do
        project.reload
        project.approval_status.should eq 'approved'
      end
    end

    describe 'error' do
      let(:project) { FactoryGirl.create :project, approval_status: 'to_improve' }
      before do 
        Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
        teacher.projects << project 
        put :update, {
          id: project.id,
          project_proposal:{
            project:{
              name: '',
              description: 'Praca polega na napisaniu aplikacja na androida toprawa opisu'
            }
          }
        }
      end

      it '400' do
        response.status.should eq 400
      end
    end
  end
end
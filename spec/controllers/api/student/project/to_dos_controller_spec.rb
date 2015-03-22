require 'spec_helper'

describe Api::Student::Project::ToDosController do
  let(:student) { FactoryGirl.create :student }
  let(:project) { FactoryGirl.create :project}

  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end

  describe '#POST done' do
    let(:to_do) { FactoryGirl.create :to_do, project: project } 
    before do
      student.projects << project
      post :done, {to_do_id: to_do.id, project_id: project.id}
    end

    it "set done" do
      response.status.should eq 201
    end
  end

  describe '#POST create' do
  	let(:student2) { FactoryGirl.create :student }
    describe 'success' do
      before do 
        student.projects << project
        post :create, {
          project_id: project.id,
          to_dos:{
  	        to_do: {
  	          name: 'kupic chleb',
  	          description: 'niedrogi'
  	        },
  	        student_ids: [student.id, student2.id]
  	      }
        }
      end

      it 'status 201' do 
        response.status.should eq 201
      end

      it "have students" do
        ToDo.last.students.count.should eq 2
      end

      it "have project" do
        ToDo.last.project.should eq project
      end
    end
  end

  describe '#GET index' do
    let(:to_do) { FactoryGirl.create :to_do, project: project } 

    before do
      student.projects << project
      to_do.students << student
      get :index, format: :json, project_id: project.id
    end

    it "200" do
      response.status.should eq 200
    end

    it { JSON.parse(response.body).first["id"].should eq to_do.id }
    it { JSON.parse(response.body).first["name"].should_not be_empty }
    it { JSON.parse(response.body).first["description"].should_not be_empty }
    it { JSON.parse(response.body).first["done"].should eq nil }
    it { JSON.parse(response.body).first["students"].count.should eq 1 }
  end
end




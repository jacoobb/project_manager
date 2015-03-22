require 'spec_helper'

describe Api::Student::Teacher::SubjectsController do
  let(:teacher) { FactoryGirl.create :teacher } 
  let(:subject) { FactoryGirl.create :subject }
  let(:student) { FactoryGirl.create :student}
  
  before do 
    Api::StudentController.any_instance.stub(:current_student).and_return student
    subject.teachers << teacher
    subject.save
  end

  describe '#get index' do
    it 'Not found teacher' do
      get :index, format: :json, teacher_id: 0
      response.status.should eq 404
    end

    it 'return subjects' do
      get :index, format: :json, teacher_id: teacher.id
      JSON.parse(response.body).first["id"].should eq subject.id
    end
  end
end
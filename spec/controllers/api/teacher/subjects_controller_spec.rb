require 'spec_helper'

describe Api::Teacher::SubjectsController do
  let(:teacher) { FactoryGirl.create :teacher } 
  let(:subject) { FactoryGirl.create :subject }
  
  before do 
    subject.teachers << teacher
    subject.save
  end

  describe '#get index' do
    it 'teacher not login' do
      get :index, format: :json, teacher_id: 0
      response.status.should eq 401
    end

    it 'return subjects' do
      Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
      get :index, format: :json
      JSON.parse(response.body).first["id"].should eq subject.id
    end
  end
end
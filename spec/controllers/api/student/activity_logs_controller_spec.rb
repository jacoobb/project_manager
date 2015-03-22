require 'spec_helper'

describe Api::Student::ActivityLogsController do
  let(:student) { FactoryGirl.create :student}
  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end
  describe '#GET index' do
    describe 'witch_student' do
      let(:project) { FactoryGirl.create :project }
      let(:student) { FactoryGirl.create :student }
      let(:student2) { FactoryGirl.create :student }
      let(:teacher) { FactoryGirl.create :teacher }

      before do 
        project.teachers << teacher
        project.students << student
        project.students << student2
        MyLogger.new.project_activity_log project, teacher, 'change_status'
        MyLogger.new.project_activity_log project, student, 'change_status'
        MyLogger.new.project_activity_log project, student2, 'change_status'
        get :index, format: :json 
      end

      it { response.status.should eq 200 }
      it { JSON.parse(response.body).count.should eq 2 }
      it { JSON.parse(response.body).first['author'].should_not be_empty }
      it { JSON.parse(response.body).first['project'].should_not be_empty }
    end
  end
end
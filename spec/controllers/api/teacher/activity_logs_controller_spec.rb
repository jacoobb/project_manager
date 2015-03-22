require 'spec_helper'

describe Api::Teacher::ActivityLogsController do
  let(:teacher) { FactoryGirl.create :teacher}
  before do
    Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
  end
  describe '#GET index' do
    describe 'witch_teacher' do
      let(:project) { FactoryGirl.create :project }
      let(:student) { FactoryGirl.create :student }
      let(:teacher2) { FactoryGirl.create :teacher }

      before do 
        project.teachers << teacher
        project.teachers << teacher2
        project.students << student
        MyLogger.new.project_activity_log project, teacher, 'change_status'
        MyLogger.new.project_activity_log project, student, 'change_status'
        MyLogger.new.project_activity_log project, teacher2, 'change_status'
        MyLogger.new.project_activity_log project, teacher2, 'change_status'
        get :index, format: :json 
      end

      it { response.status.should eq 200 }
      it { JSON.parse(response.body).count.should eq 3 }
      it { JSON.parse(response.body).first['author'].should_not be_empty }
      it { JSON.parse(response.body).first['project'].should_not be_empty }
    end
  end
end
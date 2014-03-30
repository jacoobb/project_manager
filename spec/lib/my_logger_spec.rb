require 'spec_helper'

describe MyLogger do
  it "can be instantiated" do
    MyLogger.new.should be_an_instance_of MyLogger
  end

  describe 'project_activity_log' do
    let(:student) { FactoryGirl.create :student }
    let(:project) { FactoryGirl.create :project }
    
    before { MyLogger.new.project_activity_log project, student, 'create_project' }
    it { ActivityLog.count.should eq 1 } 
    it { ActivityLog.last.student.should eq student } 
    it { ActivityLog.last.project.should eq project } 
  end
end
require 'spec_helper'

describe Project do
  it "can be instantiated" do
    Project.new.should be_an_instance_of Project
  end

  describe 'validate' do
    let(:project) { Project.new }
    before { project.valid? }

    it { project.errors[:name].should_not be_empty }
    it { project.errors[:project_type].should_not be_empty }
    it { project.errors[:description].should_not be_empty }
    it { project.errors[:subject].should be_empty }

    describe 'subject' do
      it 'presence if project_type is subject' do
        project = Project.new project_type: 'subject'
        project.valid?
        project.errors[:subject].should_not be_empty
      end
    end
  end
end

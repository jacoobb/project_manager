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

  describe 'scope' do
    describe 'diploma' do
      let!(:subject_project) { FactoryGirl.create :subject_project }
      let!(:first_degree) { FactoryGirl.create :project }
      let!(:second_degree) { FactoryGirl.create :project }
      
      it 'return two project' do
        Project.diploma.count.should eq 2
      end

      it 'return first_degree project' do
        Project.diploma.first.id.should eq first_degree.id
      end

      it 'return second_degree project' do
        Project.diploma.last.id.should eq second_degree.id
      end

    end 
  end

  describe 'object methods' do
    let!(:project) { FactoryGirl.create :project }
    describe 'reserved?' do
      it 'return false' do
        project.reserved?.should be_false
      end 

      it 'return true' do
        project.students << FactoryGirl.create(:student)
        project.reserved?.should be_true
      end 
    end
  end
end

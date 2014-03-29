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
    let!(:subject_project) { FactoryGirl.create :subject_project }
    let!(:first_degree) { FactoryGirl.create :project, project_type: 'first_degree' }
    let!(:second_degree) { FactoryGirl.create :project, project_type: 'second_degree' }
    
    describe 'diploma' do
      it 'return two project' do
        Project.diploma.count.should eq 2
      end

      it 'return first_degree project' do
        Project.diploma.first.id.should eq first_degree.id
      end

      it 'return second_degree project' do
        Project.diploma.last.id.should eq second_degree.id
      end

      describe 'approved' do
        let!(:approved_project) { FactoryGirl.create :project, project_type: 'second_degree', approval_status: 'approved' }
        it 'return approved_project' do
          Project.approved.last.should eq approved_project
        end
      end
    end 

    describe 'subject' do
      it 'return one project' do 
        Project.subject.count.should eq 1
      end
      it 'return subject_project project' do
        Project.subject.last.id.should eq subject_project.id
      end
    end

    describe 'first_degree' do
      it 'return one project' do 
        Project.first_degree.count.should eq 1
      end
      it 'return subject_project project' do
        Project.first_degree.last.id.should eq first_degree.id
      end
    end

    describe 'second_degree' do
      it 'return one project' do 
        Project.second_degree.count.should eq 1
      end
      it 'return subject_project project' do
        Project.second_degree.last.id.should eq second_degree.id
      end
    end
  end

  describe 'instance methods' do
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

    describe 'reserve' do
      let(:student){ FactoryGirl.create :student }

      it 'project have student' do
        project.reserve student
        project.students.first.should eq student
      end

      it 'return fasle' do 
        project.reserve student
        project.reserve(FactoryGirl.create :student).should be_false
      end
    end

    describe 'add_students_to_team' do
      let(:student1){ FactoryGirl.create :student }
      let(:student2){ FactoryGirl.create :student }

      it 'project team have 2 members' do
        members = [student1, student2]
        project.add_students_to_team members
        project.students.count.should eq 2
      end
    end
  end
end

require 'spec_helper'

describe Project::ProjectProposalCreator do
  let(:teacher) { FactoryGirl.create :teacher }
  let(:student) { FactoryGirl.create :student }

  it "can be instantiated" do
    Project::ProjectProposalCreator.new({test: "test"}, student).should 
      be_an_instance_of Project::ProjectProposalCreator
  end

  describe 'create project with subject' do 
    let(:subject) { FactoryGirl.create :subject}
    
    describe 'success create' do 
      before do 
        @project_proposal = {
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'subject'
          },
          teacher_id: teacher.id,
          subject_id: subject.id
        }
      end

      it 'create associate with teacher' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create
        project_proposal.project.teachers.last.id.should eq teacher.id
      end
          
      it 'create associate with subject' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create
        project_proposal.project.subject.id.should eq subject.id
      end

      it 'project_type should be subject' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create
        project_proposal.project.project_type.should eq "subject"
      end
    end
    describe 'faild create' do 
      before do 
        @project_proposal = {
          project:{
            name: '',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'subject'
          },
          subject_id: subject.id
        }
      end

      it 'create return false' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create.should be_false
      end

      it 'errors not blank' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create
        project_proposal.project.errors.blank?.should be_false
      end

      it 'teacher errors not empty' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create
        project_proposal.project.errors["teacher"].should_not be_empty
      end
    end
  end

  describe 'create project with first_degree' do 
    before do 
      @project_proposal = {
        project:{
          name: 'Aplikacja na platformę Android',
          description: 'Praca polega na napisaniu aplikacja na androida',
          project_type: 'first_degree'
        },
        teacher_id: teacher.id
      }
    end

    it 'project_type should be subject' do
      project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
      project_proposal.create
      project_proposal.project.project_type.should eq "first_degree"
    end
  end

  describe 'create project with first_degree' do 
    before do 
      @project_proposal = {
        project:{
          name: 'Aplikacja na platformę Android',
          description: 'Praca polega na napisaniu aplikacja na androida',
          project_type: 'second_degree'
        },
        teacher_id: teacher.id
      }
    end

    it 'project_type should be subject' do
      project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
      project_proposal.create
      project_proposal.project.project_type.should eq "second_degree"
    end
  end
end
















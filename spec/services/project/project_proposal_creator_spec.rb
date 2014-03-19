require 'spec_helper'

describe Project::ProjectProposalCreator do
  let(:teacher) { FactoryGirl.create :teacher }
  let(:student) { FactoryGirl.create :student }

  it "can be instantiated" do
    Project::ProjectProposalCreator.new({test: "test"}, student).should 
      be_an_instance_of Project::ProjectProposalCreator
  end

  describe 'create by student' do

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
          project_proposal.create_by_student
          project_proposal.project.teachers.last.id.should eq teacher.id
        end
            
        it 'create associate with subject' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
          project_proposal.create_by_student
          project_proposal.project.subject.id.should eq subject.id
        end

        it 'project_type have value subject' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
          project_proposal.create_by_student
          project_proposal.project.project_type.should eq "subject"
        end

        it 'approval_status have value expectant' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
          project_proposal.create_by_student
          project_proposal.project.approval_status.should eq "expectant"
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
          project_proposal.create_by_student.should be_false
        end

        it 'errors not blank' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
          project_proposal.create_by_student
          project_proposal.project.errors.blank?.should be_false
        end

        it 'teacher errors not empty' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
          project_proposal.create_by_student
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
        project_proposal.create_by_student
        project_proposal.project.project_type.should eq "first_degree"
      end
    end

    describe 'create project with second_degree' do 
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

      it 'project_type should be second_degree' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, student
        project_proposal.create_by_student
        project_proposal.project.project_type.should eq "second_degree"
      end
    end
  end

  describe 'create by teacher' do 
    let!(:subject) { FactoryGirl.create :subject}
    let!(:category) { FactoryGirl.create :category }
    let!(:technology) { FactoryGirl.create :technology }
    describe 'create project with subject' do 
      
      describe 'success create' do 
        before do 
          @project_proposal = {
            project:{
              name: 'Aplikacja na platformę Android',
              description: 'Praca polega na napisaniu aplikacja na androida',
              project_type: 'subject'
            },
            category_id: category.id,
            technology_id: technology.id,
            subject_id: subject.id
          }
        end

        it 'create associate with teacher' do
          
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.teachers.last.id.should eq teacher.id
        end

        it 'create associate with subject' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.subject.id.should eq subject.id
        end

        it 'project_type have value subject' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.project_type.should eq "subject"
        end

        it 'approval_status have value approved' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.approval_status.should eq "approved"
        end
      end

      describe 'faild create' do 
        before do 
          @project_proposal = {
            project:{
              name: 'Aplikacja na platformę Android',
              description: 'Praca polega na napisaniu aplikacja na androida',
              project_type: ''
            },
            subject_id: subject.id
          }
        end

        it 'create return false' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher.should be_false
        end

        it 'errors not blank' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.errors.blank?.should be_false
        end

        it 'project_type errors not empty' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.errors["project_type"].should_not be_empty
        end

        it 'category errors not empty' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.errors["category"].should_not be_empty
        end

        it 'technology errors not empty' do
          project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
          project_proposal.create_by_teacher
          project_proposal.project.errors["technology"].should_not be_empty
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
          category_id: category.id,
          technology_id: technology.id,
          subject_id: subject.id
        }
      end

      it 'project_type should be subject' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
        project_proposal.create_by_teacher
        project_proposal.project.project_type.should eq "first_degree"
      end
    end

    describe 'create project with second_degree' do 
      before do 
        @project_proposal = {
          project:{
            name: 'Aplikacja na platformę Android',
            description: 'Praca polega na napisaniu aplikacja na androida',
            project_type: 'second_degree'
          },
          category_id: category.id,
          technology_id: technology.id,
          subject_id: subject.id
        }
      end

      it 'project_type should be second_degree' do
        project_proposal = Project::ProjectProposalCreator.new @project_proposal, teacher
        project_proposal.create_by_teacher
        project_proposal.project.project_type.should eq "second_degree"
      end
    end
  end
end
















require 'spec_helper'

describe Project::Divider do
  let(:project) { FactoryGirl.create :subject_project }

  it "can be instantiated" do
    Project::Divider.new(project,{}).should be_an_instance_of Project::Divider
  end
  
  describe 'divide' do
    let(:divisions) do[
        {name: "podzial 1", description: 'frontend'},
        {name: "podzial 2", description: 'backend'}
      ]
    end

    it 'create two project' do
      Project::Divider.new(project, divisions).divide
      Project.count.should eq 3
    end

    it 'the same project type' do
      Project::Divider.new(project, divisions).divide
      Project.last.project_type.should eq project.project_type
    end

    it 'the same subject' do
      Project::Divider.new(project, divisions).divide
      Project.last.subject.should eq project.subject
    end

    it 'father_id' do
      Project::Divider.new(project, divisions).divide
      Project.last.father_id.should eq project.id
    end

    it 'approval_status is divided' do
      Project::Divider.new(project, divisions).divide
      project.approval_status.should eq 'divided'
    end
  end

  describe 'return false' do 
    it 'name or description is nil' do
      divisions = [{name: "podzial 1", description: ''},
        {name: "podzial 2", description: 'backend'}]
      Project::Divider.new(project, divisions).divide.should be_false
    end    

    it 'one new project' do
      divisions = [{name: "podzial 1", description: ''}]
      Project::Divider.new(project, divisions).divide.should be_false
    end    
  end
end
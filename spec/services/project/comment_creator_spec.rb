require 'spec_helper'

describe Project::CommentCreator do
  let(:project) { FactoryGirl.create :project }
  it "can be instantiated" do
    Project::CommentCreator.new(project, {}).should be_an_instance_of Project::CommentCreator
  end

  describe 'succes' do
    it 'create' do
      comments = { name: {text: 'temat nie na temat'},
            description: {text: 'opis malo szczegolowy'}}
      Project::CommentCreator.new(project, comments).create
      Comment.count.should eq 2    
    end

    it 'project have two comments' do
      comments = { name: {text: 'temat nie na temat'},
            description: {text: 'opis malo szczegolowy'}}
      Project::CommentCreator.new(project, comments).create
      project.comments.count.should eq 2
    end

    it 'project have two comments' do
      comments = { name: {text: 'temat nie na temat'}}
      Project::CommentCreator.new(project, comments).create
      project.comments.count.should eq 1
    end

    it 'project have two comments' do
      comments = { name: {text: 'temat nie na temat'}}
      Project::CommentCreator.new(project, comments).create
      project.approval_status.should eq 'to_improve'
    end
  end

  describe 'error' do
    it 'return false' do
      comments = { name: {text: ''},
            description: {text: 'opis malo szczegolowy'}}
      Project::CommentCreator.new(project, comments).create.should be_false
    end
  end
end


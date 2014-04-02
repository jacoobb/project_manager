require 'spec_helper'

describe Chat do
  it "can be instantiated" do
    Chat.new.should be_an_instance_of Chat
  end
  
  describe 'class methods' do
    describe 'by_student' do
      let(:teacher) { FactoryGirl.create :teacher }
      let(:student) { FactoryGirl.create :student }
      let(:student2) { FactoryGirl.create :student }
      let(:project) { FactoryGirl.create :project }

      before do 
        atr = {
          message: 'nie damy rady!!',
          student_recipient_ids: [student2.id],
          teacher_recipient_ids: [teacher.id]
        }
        Chat::MessageCreator.new(student, project, atr).create_by_student

        atr = {
          message: 'nie damy rady!!',
          student_recipient_ids: [student2.id],
          teacher_recipient_ids: [teacher.id]
        }
        Chat::MessageCreator.new(student2, project, atr).create_by_student
      end

      it do 
        Chat.by_student(student).count.should eq 1
      end
    end

    describe 'by_teacher' do
      let(:teacher) { FactoryGirl.create :teacher }
      let(:student) { FactoryGirl.create :student }
      let(:student2) { FactoryGirl.create :student }
      let(:project) { FactoryGirl.create :project }

      before do 
        atr = {
          message: 'nie damy rady!!',
          student_recipient_ids: [student2.id],
          teacher_recipient_ids: [teacher.id]
        }
        Chat::MessageCreator.new(student, project, atr).create_by_student

        atr = {
          message: 'nie damy rady!!',
          student_recipient_ids: [student2.id],
          teacher_recipient_ids: []
        }
        Chat::MessageCreator.new(student2, project, atr).create_by_student
      end

      it do 
        Chat.by_teacher(teacher).count.should eq 1
      end
    end
  end
end

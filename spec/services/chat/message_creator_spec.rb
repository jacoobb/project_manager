require 'spec_helper'

describe Chat::MessageCreator do
  let(:teacher) { FactoryGirl.create :teacher }
  let(:student) { FactoryGirl.create :student }
  let(:student2) { FactoryGirl.create :student }
  let(:project) { FactoryGirl.create :project }

  it "can be instantiated" do
    Chat::MessageCreator.new(student, project,{test: "test"}).should 
      be_an_instance_of Chat::MessageCreator
  end

  describe 'teacher create message' do
    before do 
      atr = {
        message: 'zacznamy!!',
        student_recipient_ids: [student.id, student2.id],
        teacher_recipient_ids: [teacher.id]
      }
      Chat::MessageCreator.new(teacher, project, atr).create_by_teacher
    end

    it 'set sender' do
      Chat.last.sender.should eq teacher
    end

    it 'set student_recipient' do
      Chat.last.students.count.should eq 2
    end

    it 'set teacher_recipient' do
      Chat.last.teachers.count.should eq 1
    end

    describe 'wrong params' do
      it 'return false' do
        atr = {
          student_recipient_ids: [student.id, student2.id],
          teacher_recipient_ids: []
        }
        Chat::MessageCreator.new(teacher, project, atr).create_by_teacher.should be_false
      end
    end
  end

  describe 'student create message' do
    before do 
      atr = {
        message: 'nie damy rady!!',
        student_recipient_ids: [student2.id, student.id],
        teacher_recipient_ids: [teacher.id]
      }
      Chat::MessageCreator.new(student, project, atr).create_by_student
    end

    it 'set sender' do
      Chat.last.sender.should eq student
    end

    it 'set student_recipient' do
      Chat.last.students.count.should eq 2
    end

    it 'set teacher_recipient' do
      Chat.last.teachers.count.should eq 1
    end

    describe 'wrong params' do
      it 'return false' do
        atr = {
          student_recipient_ids: [student.id, student2.id],
          teacher_recipient_ids: [teacher.id]
        }
        Chat::MessageCreator.new(student, project, atr).create_by_student.should be_false
      end
    end
  end
end
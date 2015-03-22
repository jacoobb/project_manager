require 'spec_helper'

describe ActivityLog do
  it "can be instantiated" do
    ActivityLog.new.should be_an_instance_of ActivityLog
  end

  describe 'validate' do
    let(:activity_log) { ActivityLog.new }
    before { activity_log.valid? }

    it { activity_log.errors[:name].should_not be_empty }
    it { activity_log.errors[:teacher].should_not be_empty }
    it { activity_log.errors[:student].should_not be_empty }

    describe 'teacher or student should be presence' do
      describe 'teacher presence ' do
        let(:teacher) { FactoryGirl.create :teacher }
        before do 
          activity_log.teacher_id = teacher.id
          activity_log.valid?
        end
        it { activity_log.errors[:student].should be_empty }
        it { activity_log.errors[:teacher].should be_empty }
      end

      describe 'student presence ' do
        let(:student) { FactoryGirl.create :student }
        before do 
          activity_log.student_id = student.id
          activity_log.valid?
        end
        it { activity_log.errors[:student].should be_empty }
        it { activity_log.errors[:teacher].should be_empty }
      end
    end
  end

  describe 'class methods' do
    # project_activity_log
    describe 'witch_teacher' do
      let(:project) { FactoryGirl.create :project }
      let(:student) { FactoryGirl.create :student }
      let(:teacher) { FactoryGirl.create :teacher }

      before do 
        project.teachers << teacher
        MyLogger.new.project_activity_log project, student, 'create_project_proposal'
        MyLogger.new.project_activity_log project, teacher, 'change_status'
        MyLogger.new.project_activity_log project, student, 'reserve_project'
      end

      it 'teacher have activity_log' do
        ActivityLog.witch_teacher(teacher).count.should eq 2
      end
    end

    describe 'witch_student' do
      let(:project) { FactoryGirl.create :project }
      let(:student) { FactoryGirl.create :student }
      let(:student2) { FactoryGirl.create :student }
      let(:teacher) { FactoryGirl.create :teacher }

      before do 
        project.teachers << teacher
        project.students << student
        project.students << student2
        MyLogger.new.project_activity_log project, teacher, 'change_status'
        MyLogger.new.project_activity_log project, student, 'change_status'
        MyLogger.new.project_activity_log project, student2, 'change_status'
      end

      it 'teacher have activity_log' do
        ActivityLog.witch_student(student).count.should eq 2
      end
    end
  end

  describe 'instance methos' do 
    describe 'author=' do
      let(:student) { FactoryGirl.create :student }
      let(:teacher) { FactoryGirl.create :teacher }
      it 'add student' do
        activity_log = ActivityLog.new
        activity_log.author = student
        activity_log.student.should eq student
      end

      it 'add teacher' do
        activity_log = ActivityLog.new
        activity_log.author = teacher
        activity_log.teacher.should eq teacher
      end
    end
    describe 'author' do
      let(:student) { FactoryGirl.create :student }
      let(:teacher) { FactoryGirl.create :teacher }
      it 'get student' do
        activity_log = ActivityLog.new
        activity_log.author = student
        activity_log.author.should eq student
      end
      it 'get teacher' do
        activity_log = ActivityLog.new
        activity_log.author = teacher
        activity_log.author.should eq teacher
      end
    end
  end
end

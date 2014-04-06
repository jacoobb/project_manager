class ActivityLog < ActiveRecord::Base
  ACTIONS = %w(create_project reserve_project create_project_proposal
               add_student_to_team change_status add_comment)

  belongs_to :student
  belongs_to :teacher
  belongs_to :project

  validates :name, presence: true, inclusion: {in: ACTIONS}
  validates :project, presence: true
  validates :student, presence: {unless: "teacher"}
  validates :teacher, presence: {unless: "student"}

  class << self
    def witch_teacher teacher
      project_ids = Project.joins(:activity_logs).joins(:teachers).
        where("teachers.id = ?", teacher.id).map {|p| p.id}
        where("teacher_id != ? or teacher_id IS NULL", teacher.id).
      where(project_id: project_ids).sort
    end

    def witch_student student
      project_ids = Project.joins(:activity_logs).joins(:students).
        where("students.id = ?", student.id).map {|p| p.id}
      where("student_id != ? or student_id IS NULL", student.id).
       where(project_id: project_ids).sort
    end
  end

  def author
    student ? student : teacher
  end

  def authot_type
    return 'student' if student
    return 'teacher' if teacher
  end

  def author= author
    if author.class == Student
      self.student_id = author.id
    elsif author.class == Teacher
      self.teacher_id = author.id
    end
  end
end

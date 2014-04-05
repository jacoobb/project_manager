class Chat < ActiveRecord::Base

  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  belongs_to :project
  belongs_to :teacher
  belongs_to :student
  
  validates :message, presence: true
  validates :project, presence: true
  validates :student, presence: {unless: "teacher"}
  validates :teacher, presence: {unless: "student"}

  class << self
    def by_student student
      joins(:students).where("students.id = ?", student.id)
    end

    def by_teacher teacher
      joins(:teachers).where("teachers.id = ?", teacher.id)
    end
  end

  def sender
    student ? student : teacher
  end

  def sender_type
    return 'student' if student
    return 'teacher' if teacher
  end
end

class Project < ActiveRecord::Base
  PROJECT_TYPE = %w(subject first_degree second_degree diploma)
  APPROVAL_STATUS = %w(expectant approved rejected to_improve finished)

  belongs_to :subject
  has_many :activity_logs
  has_many :chats
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :students
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :technologies

  validates :name, presence: true
  validates :description, presence: true
  validates :project_type, presence: true, inclusion: {in: PROJECT_TYPE}
  validates :approval_status, presence: true, inclusion: {in: APPROVAL_STATUS}
  validates :subject, presence: {if: "project_type == 'subject'"}

  class << self
    def diploma
      where "project_type = 'first_degree' OR project_type = 'second_degree' OR project_type = 'diploma'"
    end

    def subject
      where project_type: 'subject'
    end

    def first_degree
      where project_type: 'first_degree'
    end

    def second_degree
      where project_type: 'second_degree'
    end

    def approved
      where approval_status: 'approved'
    end
  end

  def reserved?
    return true if students.count > 0
    false
  end

  def reserve student
    students.empty? ? self.students << student : false
  end

  def add_students_to_team members
    members.each {|m| self.students << m}
  end

end

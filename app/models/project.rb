class Project < ActiveRecord::Base
  PROJECT_TYPE = %w(subject first_degree second_degree)
  APPROVAL_STATUS = %w(expectant approved rejected to_improve finished)

  belongs_to :subject
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :students
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :description, presence: true
  validates :project_type, presence: true, inclusion: {in: PROJECT_TYPE}
  validates :approval_status, presence: true, inclusion: {in: APPROVAL_STATUS}
  validates :subject, presence: {if: "project_type == 'subject'"}

end

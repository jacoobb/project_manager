class Project < ActiveRecord::Base
  PROJECT_TYPE = %w(subject first_degree second_degree)

  belongs_to :subject
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :students

  validates :name, presence: true
  validates :description, presence: true
  validates :project_type, presence: true, inclusion: {in: PROJECT_TYPE}
  validates :subject, presence: {if: "project_type == 'subject'"}

end

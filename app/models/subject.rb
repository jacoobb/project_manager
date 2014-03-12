class Subject < ActiveRecord::Base
  SUBJECT_TYPE = %w(lecture lab project)

  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  
  validates :name, presence: true
  validates :subject_type, inclusion: {in: SUBJECT_TYPE}
end

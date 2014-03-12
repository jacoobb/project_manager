class Project < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :descriotion, presence: true

end

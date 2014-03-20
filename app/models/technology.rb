class Technology < ActiveRecord::Base
  has_and_belongs_to_many :projects

  validates :name, presence: true, uniqueness: true
end

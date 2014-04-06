class Comment < ActiveRecord::Base
  COMMENT_TYPE = %w(to_topic to_description)

  belongs_to :project

  validates :text, presence: true
  validates :comment_type, presence: true, inclusion: {in: COMMENT_TYPE}
  validates :project, presence: true
end

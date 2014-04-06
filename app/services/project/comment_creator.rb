class Project::CommentCreator

  def initialize project, args
    @args = args
    @project = project
  end

  def create
    comment_to_topic = create_comment_to_topic
    comment_to_description = create_comment_to_description
    return false unless comment_to_topic & comment_to_description
    @project.approval_status = 'to_improve'
    @project.save
  end

  private
    def create_comment_to_topic
      return true unless @args[:name]  
      comment = Comment.new @args[:name]  
      comment.comment_type = "to_topic"
      comment.project_id = @project.id
      comment.save
    end

    def create_comment_to_description
      return true unless @args[:description]  
      comment = Comment.new @args[:description]  
      comment.comment_type = "to_description"
      comment.project_id = @project.id
      comment.save
    end
end
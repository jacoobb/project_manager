class Chat::MessageCreator
  def initialize sender, project, args
    @args = args
    @sender = sender
    @chat = ::Chat.new message: @args[:message]
    @chat.project_id = project.id
  end

  def create_by_teacher
    @chat.teacher_id = @sender.id
    return unless @chat.valid?
    @chat.save
    @chat.teachers << @chat.sender
    add_recipient
  end

  def create_by_student
    @chat.student_id = @sender.id
    return false unless @chat.valid?
    @chat.save
    @chat.students << @chat.sender
    add_recipient
  end
  
  private 
    def add_recipient
      @args[:teacher_recipient_ids].each {|id| @chat.teachers << Teacher.find_by(id: id)}
      @args[:student_recipient_ids].each {|id| @chat.students << Student.find_by(id: id)}
    end

end
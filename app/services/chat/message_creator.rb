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
    add_recipients
  end

  def create_by_student
    @chat.student_id = @sender.id
    return false unless @chat.valid?
    @chat.save
    @chat.students << @chat.sender
    add_recipients
  end
  
  private 
    def add_recipients
      add_teacher_recipients if @args[:teacher_recipient_ids]
      add_student_recipients if @args[:student_recipient_ids]
    end

    def add_teacher_recipients
      @args[:teacher_recipient_ids].each do |id|
        @chat.teachers << Teacher.find_by(id: id) unless @chat.teachers.find_by(id: id)
      end
    end

    def add_student_recipients
      @args[:student_recipient_ids].each do |id| 
        @chat.students << Student.find_by(id: id) unless @chat.students.find_by(id: id)
      end
    end

end
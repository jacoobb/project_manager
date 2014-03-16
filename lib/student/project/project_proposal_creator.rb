class Student::Project::ProjectProposalCreator
  attr_accessor :project

  def initialize arg, student
    @arg = arg
    @student = student
  end

  def create
    @project = ::Project.new @arg[:project]
    @project.subject = ::Subject.find @arg[:subject_id] if @arg[:subject_id]
    return false unless valid?
    save
    @project
  end


  private

    def save
      @project.save
      @project.teachers << Teacher.find(@arg[:teacher_id])
      @project.students << @student
    end

    def valid?
      @project.valid?
      @project.errors[:teacher] = "can't be blank" unless @arg[:teacher_id]
      return true if @project.errors.blank?
    end
end
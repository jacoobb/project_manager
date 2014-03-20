class Project::ProjectProposalCreator
  attr_accessor :project

  def initialize arg, author
    @arg = arg
    @author = author
    @project = ::Project.new @arg[:project]
    @project.subject = Subject.find @arg[:subject_id] if @arg[:subject_id]
  end

  def create_by_teacher
    @project.approval_status = 'approved'
    return false unless teacher_project_valid?
    @project.save
    @project.teachers << @author
    @project.categories << Category.find(@arg[:category_id])
    @project.technologies << Technology.find(@arg[:technology_id])
  end

  def create_by_student
    @project.approval_status = 'expectant'
    return false unless student_project_valid?
    @project.save
    @project.teachers << Teacher.find(@arg[:teacher_id])
    @project.students << @author
  end


  private

    def student_project_valid?
      @project.valid?
      @project.errors[:teacher] = "can't be blank" unless @arg[:teacher_id]
      return true if @project.errors.blank?
    end

    def teacher_project_valid?
      @project.valid?
      @project.errors[:category] = "can't be blank" unless @arg[:category_id]
      @project.errors[:technology] = "can't be blank" unless @arg[:technology_id]
      return true if @project.errors.blank?
    end
end
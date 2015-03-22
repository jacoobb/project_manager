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
    @arg[:category_ids].each {|id| @project.categories << Category.find(id)}
    @arg[:technology_ids].each {|id| @project.technologies << Technology.find(id)}
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
      @project.errors[:category_ids] = "can't be blank" unless @arg[:category_ids]
      @project.errors[:technology_ids] = "can't be blank" unless @arg[:technology_ids]
      return true if @project.errors.blank?
    end
end
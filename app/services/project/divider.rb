class Project::Divider
  def initialize father_project, divisions
    @divisions = divisions
    @father_project = father_project
  end

  def divide
    return false if @divisions.count < 2 || !divisions_valid?
    @divisions.each do |d| 
      project = create_project d[:name], d[:description]
      copy_form_father project
    end
    @father_project.approval_status = 'divided'
    @father_project.save
  end


  private 

    def divisions_valid?
      @divisions.each do |d|
        return false if d[:name].empty? || d[:description].empty?
      end
    end

    def create_project name, description
      project = Project.new name: name, description: description
      project.approval_status = 'approved'
      copy_setting_form_father project
      project.save
      project
    end

    def copy_setting_form_father project
      project.project_type = @father_project.project_type
      project.subject = @father_project.subject if project.project_type == 'subject'
      project.father_id = @father_project.id
    end

    def copy_form_father project
      @father_project.teachers.each {|t| project.teachers << t}
      @father_project.categories.each {|c| project.categories << c}
      @father_project.technologies.each {|t| project.technologies << t}
    end
end
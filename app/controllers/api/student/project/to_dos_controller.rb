class Api::Student::Project::ToDosController < Api::Student::ProjectController

  def index
  	@to_dos = current_project.to_dos
  end
  
  def create
    to_do = ToDo.new params_chats[:to_do]
    to_do.project = current_project
    if to_do.save
      MyLogger.new.project_activity_log current_project, current_student, 'add_to_do_to_project'
      params_chats[:student_ids].each {|id| to_do.students << Student.find(id)}
      head 201    	
    else
      head 400
    end    
  end

  def done
    to_do = current_project.to_dos.find params[:to_do_id]
    to_do.done = true
    if to_do.save
      MyLogger.new.project_activity_log current_project, current_student, 'to_do_is_dane'
      head 201
    else
      head 400
    end
  end


  private

    def params_chats
      params.require(:to_dos).permit to_do: [:name, :description], student_ids: []
    end
end
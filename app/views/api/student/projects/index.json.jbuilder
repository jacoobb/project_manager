json.array! @projects do |project|
  json.id project.id
  json.name project.name
  json.description project.description
  json.project_type project.project_type
  json.subject do
    json.id project.subject.id
    json.name project.subject.name
    json.subject_type project.subject.subject_type
  end
  json.teachers project.teachers do |teacher|
    json.id teacher.id
    json.academic_title teacher.academic_title
    json.first_name teacher.first_name
    json.last_name teacher.last_name
    json.phone_number teacher.phone_number
    json.email teacher.email
  end
  json.members project.students do |student|
    json.matricula_number student.matricula_number
    json.first_name student.first_name
    json.last_name student.last_name
    json.phone_number student.phone_number
    json.email student.email
  end
end
json.array! @logs do |log|
  json.id log.id
  json.created_at log.created_at
  json.name log.name 
  json.author do
    json.id log.author.id
    json.authot_type log.authot_type
    json.academic_title log.author.academic_title if log.authot_type == 'teacher'
    json.first_name log.author.first_name
    json.last_name log.author.last_name
    json.phone_number log.author.phone_number
    json.email log.author.email
  end
  json.project do 
    json.id log.project.id
    json.name log.project.name
    json.description log.project.description
    json.project_type log.project.project_type
    json.approval_status log.project.approval_status
    json.reserved log.project.reserved?
    json.teachers log.project.teachers do |teacher|
      json.id teacher.id
      json.academic_title teacher.academic_title
      json.first_name teacher.first_name
      json.last_name teacher.last_name
      json.phone_number teacher.phone_number
      json.email teacher.email
    end
    json.members log.project.students do |student|
      json.id student.id
      json.first_name student.first_name
      json.last_name student.last_name
      json.phone_number student.phone_number
      json.email student.email
    end
    json.categories log.project.categories do |category|
      json.name category.name 
    end
    json.technologies log.project.technologies do |technology|
      json.name technology.name 
    end
  end
end
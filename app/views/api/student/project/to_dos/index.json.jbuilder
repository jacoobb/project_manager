json.array! @to_dos do |to_do|
  json.id to_do.id
  json.name to_do.name
  json.description to_do.description
  json.done to_do.done
  json.students to_do.students do |student|
    json.id student.id
    json.first_name student.first_name
    json.last_name student.last_name
  end
end
json.array! @teachers do |teacher|
  json.id teacher.id
  json.academic_title teacher.academic_title
  json.first_name teacher.first_name
  json.last_name teacher.last_name
  json.phone_number teacher.phone_number
  json.email teacher.email
end

json.array! @chats do |chat|
  json.id chat.id
  json.message chat.message
  json.sender do
    json.id chat.sender.id
    json.sender_type chat.sender_type
    json.academic_title chat.sender.academic_title if chat.sender_type == 'teacher'
    json.first_name chat.sender.first_name
    json.last_name chat.sender.last_name
    json.phone_number chat.sender.phone_number
    json.email chat.sender.email
  end
  json.student_recipients chat.students do |student|
    json.id student.id
    json.first_name student.first_name
    json.last_name student.last_name
  end
  json.teacher_recipients chat.teachers do |teacher|
    json.id teacher.id
    json.academic_title teacher.academic_title
    json.first_name teacher.first_name
    json.last_name teacher.last_name
  end
end
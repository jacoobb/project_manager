unless Student.find_by student_id: '88456'
  student = Student.new do |s|
    s.first_name = "Maciek"
    s.last_name = 'Ogrodniczak'
    s.password = '12qwaszx'
    s.password_confirmation = '12qwaszx'
    s.phone_number = '567567567'
    s.student_id = '88456'
    s.pesel = '90081801789'
    s.email = 'ogor@malutli.com'
  end
  puts "Dodano studenta #{student.first_name}." if student.save!
end
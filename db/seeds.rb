unless Student.find_by matricula_number: '88456'
  student = Student.new do |s|
    s.first_name = "Maciek"
    s.last_name = 'Ogrodniczak'
    s.password = '12qwaszx'
    s.password_confirmation = '12qwaszx'
    s.phone_number = '567567567'
    s.matricula_number = '88456'
    s.pesel = '90081801789'
    s.email = 'ogor@malutli.com'
  end
  puts "Dodano studenta #{student.first_name}." if student.save!
end

unless Teacher.find_by email: 'zabawa@gmail.com'
  teacher = Teacher.new do |s|
    s.first_name = "Piotr"
    s.last_name = 'Zabawa'
    s.password = '12qwaszx'
    s.password_confirmation = '12qwaszx'
    s.phone_number = '567567569'
    s.email = 'zabawa@gmail.com'
    s.academic_title = 'dr inż.'
  end
  puts "Dodano nauczyciela #{teacher.first_name}." if teacher.save!
end

unless Teacher.find_by email: 'nowak@gmail.com'
  teacher = Teacher.new do |s|
    s.first_name = "Jan"
    s.last_name = 'Nowak'
    s.password = '12qwaszx'
    s.password_confirmation = '12qwaszx'
    s.phone_number = '567567349'
    s.email = 'nowak@gmail.com'
    s.academic_title = 'dr inż.'
  end
  puts "Dodano nauczyciela #{teacher.first_name}." if teacher.save!
end

unless Teacher.find_by email: 'jamroz@gmail.com'
  teacher = Teacher.new do |s|
    s.first_name = "Lech"
    s.last_name = 'Jamroz'
    s.password = '12qwaszx'
    s.password_confirmation = '12qwaszx'
    s.phone_number = '561567349'
    s.email = 'jamroz@gmail.com'
    s.academic_title = 'dr inż.'
  end
  puts "Dodano nauczyciela #{teacher.first_name}." if teacher.save!
end
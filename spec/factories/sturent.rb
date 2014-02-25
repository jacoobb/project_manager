FactoryGirl.define do
  factory :student do    
    first_name 'tester'
    last_name 'tester'
    password 'tester'
    password_confirmation 'tester' 
    phone_number '725678765'

    sequence :student_id do |n|
      "8845#{n}"
    end

    sequence :pesel do |n|
      "900918#{n}"
    end

    sequence :email do |n|
      "tester#{n}@tester.com"
    end

  end
end
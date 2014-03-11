FactoryGirl.define do
  factory :teacher do    
    first_name 'tester'
    last_name 'tester'
    password 'tester'
    password_confirmation 'tester' 
    phone_number '725678765'
    academic_title 'mgr'
    
    sequence :email do |n|
      "tester#{n}@tester.com"
    end

  end
end
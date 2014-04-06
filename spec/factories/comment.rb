FactoryGirl.define do
  factory :comment do  
    text 'do poprawki'
    comment_type 'to_description'
    project
  end
end
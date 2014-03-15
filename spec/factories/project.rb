FactoryGirl.define do
  factory :project do    

    sequence :name do |n|
      "Aplilacja testowa - #{n}"
    end

    description 'Test'
    project_type 'first_degree'
    
  end
end
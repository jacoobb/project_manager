FactoryGirl.define do
  factory :project do    

    sequence :name do |n|
      "Aplilacja testowa - #{n}"
    end

    description 'Test'
    project_type 'first_degree' 
    approval_status 'approved'
  end

  factory :subject_project, parent: :project do
    project_type 'subject'
    subject
  end

  factory :diploma_project, parent: :project do
    project_type 'first_degree'
  end
end
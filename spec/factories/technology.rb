FactoryGirl.define do
  factory :technology do    

    sequence :name do |n|
      "Technologia - #{n}"
    end
    
  end
end
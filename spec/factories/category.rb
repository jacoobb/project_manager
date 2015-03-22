FactoryGirl.define do
  factory :category do    

    sequence :name do |n|
      "Kategoria - #{n}"
    end
    
  end
end
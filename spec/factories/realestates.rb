FactoryGirl.define do
  factory :realestate do
    name { Faker::Company.name }
    published true
  end
end

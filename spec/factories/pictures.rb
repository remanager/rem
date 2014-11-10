FactoryGirl.define do
  factory :picture do
    association :property
    association :realestate
    description Faker::Lorem.paragraph
  end
end

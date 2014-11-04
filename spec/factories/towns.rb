FactoryGirl.define do
  factory :town do
    sequence(:postcode, 10000)
    name { Faker::Address.city }
  end
end

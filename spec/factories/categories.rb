FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.word.upcase }
  end
end

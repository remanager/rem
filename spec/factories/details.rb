FactoryGirl.define do
  factory :detail do
    name { Faker::Product.product }
  end
end

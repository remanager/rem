FactoryGirl.define do
  factory :realestate do
    sequence(:name) { |n| "RealEstate_#{n}"}

    trait(:with_agent) { association :user, factory: [:user, :agent] }
  end
end

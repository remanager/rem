FactoryGirl.define do
  factory :realestate do
    sequence (:name) { |n| "RealEstate_#{n}"}
    association :user
  end
end

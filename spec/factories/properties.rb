FactoryGirl.define do
  factory :property do
    sequence (:ref) { |n| "Ref_#{n}" }
    association :town
    association :user
  end
end

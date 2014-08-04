FactoryGirl.define do
  factory :town do
    postcode '01234'
    sequence (:name) { |n| "Town_#{n}" }
  end
end

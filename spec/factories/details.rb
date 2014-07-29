FactoryGirl.define do
  factory :detail do
    sequence (:name) { |n| "Detail_#{n}" }
  end
end

FactoryGirl.define do
  factory :property do
    sequence (:ref) { |n| "Ref_#{n}" }
    title { Faker::Lorem.word }
    association :town
    association :user

    # after(:create) do |property|
    #   property.categories << create(:category)
    #   property.details << create(:detail)
    # end
  end
end

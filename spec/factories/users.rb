FactoryGirl.define do
  factory :user do
    sequence (:email) { |n| "user#{n}@example.com" }
    password 'password'

    trait(:admin) { role ROLES[:admin] }
  end
end

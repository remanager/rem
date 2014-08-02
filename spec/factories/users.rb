FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait(:admin) { role :admin }
    trait(:agent) {
      role :agent
      association :realestate
    }
    trait(:owner) { role :owner }
  end
end

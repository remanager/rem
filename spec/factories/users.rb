FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait(:admin) { role ROLES.index :admin }
    trait(:agent) {
      role ROLES.index :agent
      association :realestate
    }
    trait(:owner) { role ROLES.index :owner }
  end
end

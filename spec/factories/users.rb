FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '123456'
    password_confirmation '123456'

    trait(:admin) { role :admin }
    trait(:agent) { role :agent }
    trait(:with_realestate) { association :realestate }
    # Regular user is an Owner
    # trait(:owner) { role :owner }

    factory :user_admin, traits: [:admin]
    factory :user_agent, traits: [:agent]
    factory :user_agent_with_realestate, traits: [:agent, :with_realestate]
  end
end

FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name 'user1'
    password 'password1'
    email { generate(:email) }
  end
end

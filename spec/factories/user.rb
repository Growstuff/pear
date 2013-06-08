FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name 'user1'
    password 'password1'
    email { generate(:email) }

    factory :available_no_tz_user do
      available true
    end

    factory :available_user do
      time_zone 'London'
      available true
    end

    factory :london_user do
      time_zone 'London'
      available true
    end

    factory :sydney_user do
      time_zone 'Sydney'
      available true
    end

    factory :la_user do
      time_zone 'Pacific Time (US & Canada)'
      available true
    end

    factory :mentor do
      time_zone "London"
      available true
      can_mentor true
      wants_mentor true
    end

  end

end

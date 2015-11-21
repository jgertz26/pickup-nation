require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "coolguy#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    admin false
  end

  factory :court_type do
    description "Outdoor with lights"
  end

  factory :court do
    sequence(:name) { |n| "Dinkle Park Courts#{n}" }
    sequence(:street_address) { |n| "#{n} Beacon St" }
    city 'Boston'
    state 'MA'
    zip '02467'
    court_type
    hoop_count 4
    latitude 40.11245
    longitude -0.012345
  end

  factory :meetup do
    description "Gon' hoop"
    start_time Time.now - 4.hours
    court
    user
  end

end

require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "coolguy#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { User::ROLES[:free] }

    trait :with_premium do
      role { User::ROLES[:premium] }
    end
  end
end

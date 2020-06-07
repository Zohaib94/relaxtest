# frozen_string_literal: true

FactoryBot.define do
  factory :dashboard do
    title { Faker::Lorem.sentence }
    association :user

    trait :invalid do
      title { nil }
    end
  end
end

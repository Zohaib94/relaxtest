# frozen_string_literal: true

FactoryBot.define do
  factory :dashboard do
    title { Faker::Lorem.sentence }
    order { Faker::Number.unique.between(from: 1, to: 1000) }
    association :user

    trait :invalid do
      title { nil }
    end
  end
end

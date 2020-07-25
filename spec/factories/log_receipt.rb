# frozen_string_literal: true

FactoryBot.define do
  factory :log_receipt do
    invoiced_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }

    amount { Faker::Number.number(digits: 3) }
    quantity { Faker::Number.number(digits: 3) }
    average_weight { Faker::Number.number(digits: 3) }
    average_diameter { Faker::Number.number(digits: 3) }
    average_length { Faker::Number.number(digits: 3) }

    association :user

    factory :with_image do
      after(:create) do |log_receipt|
        create(:log_image, log_receipt: log_receipt)
      end
    end

    trait :invalid do
      amount { nil }
    end
  end
end

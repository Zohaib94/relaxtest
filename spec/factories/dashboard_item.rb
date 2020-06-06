# frozen_string_literal: true

FactoryBot.define do
  factory :dashboard_item do
    content { Faker::Lorem.sentence }
    item_type { 0 }
    association :dashboard
  end
end

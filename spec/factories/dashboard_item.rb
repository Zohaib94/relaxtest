# frozen_string_literal: true

FactoryBot.define do
  factory :dashboard_item do
    content { Faker::Lorem.sentence }
    item_type { 'text_content' }
    display { true }
    association :dashboard
  end
end

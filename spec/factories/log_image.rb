# frozen_string_literal: true

FactoryBot.define do
  factory :log_image do
    attached_image { Rack::Test::UploadedFile.new('spec/support/assets/test-image.png', 'image/png') }

    association :log_receipt

    trait :invalid do
      attached_image { nil }
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    business
    title { Faker::Lorem.characters(6) }
    body { Faker::Lorem.sentence }
  end
end

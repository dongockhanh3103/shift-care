# frozen_string_literal: true

FactoryBot.define do
  factory :plumber do
    name { Faker::Name.unique.name }
    address { Faker::Address.full_address }
  end
end

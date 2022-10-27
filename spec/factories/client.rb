# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.unique.name }
    address { Faker::Address.full_address }
    age { (18..100).to_a.sample }
    private_note { Faker::Lorem.sentence }
  end
end

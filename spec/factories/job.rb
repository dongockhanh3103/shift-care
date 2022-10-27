# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    client
    state { 'open' }
    entry_time { Time.current }
  end
end

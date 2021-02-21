# frozen_string_literal: true

FactoryBot.define do
  factory :match_day do
    round
    stop_bet_time { 1.day.from_now }
    day_number { Faker::Number.unique.between(from: 1, to: 500) }
  end
end

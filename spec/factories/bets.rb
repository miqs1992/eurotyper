# frozen_string_literal: true

FactoryBot.define do
  factory :bet do
    match
    user
    score1 { Faker::Number.unique.between(from: 0, to: 10) }
    score2 { Faker::Number.unique.between(from: 0, to: 10) }
  end
end

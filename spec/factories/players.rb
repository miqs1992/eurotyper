# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    name { Faker::Address.unique.country }
    position { :forward }
    goals { Faker::Number.non_zero_digit }
    team
  end
end

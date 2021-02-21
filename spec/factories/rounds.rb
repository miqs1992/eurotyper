# frozen_string_literal: true

FactoryBot.define do
  factory :round do
    sequence(:name) { |n| "Round #{n}" }
    score_factor { 1 }
  end
end

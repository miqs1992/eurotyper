# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Address.unique.country }
    flag { Faker::Address.unique.country_code }
  end
end

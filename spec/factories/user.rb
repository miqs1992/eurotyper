# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }

    factory :admin do
      admin { true }
    end
  end
end

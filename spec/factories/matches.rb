# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    start_time { Time.current }
    match_day
    team1 factory: :team
    team2 factory: :team
  end
end

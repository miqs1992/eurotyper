# frozen_string_literal: true

json.name @round.name
json.users User.all do |user|
  json.extract! user, :id, :name
  json.points user.bets.where(match_id: @round.matches.select(:id)).sum(:points)
  json.exact_bet_count user.bets.exact.where(match_id: @round.matches.select(:id)).count
end

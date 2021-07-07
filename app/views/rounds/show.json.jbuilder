# frozen_string_literal: true

json.users User.all do |user|
  json.extract! user, :id, :name
  json.points user.bets.where(match: @matches).sum(:points)
  json.exact_bet_count user.bets.exact.where(match: @matches).count
end

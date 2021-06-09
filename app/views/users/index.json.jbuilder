# frozen_string_literal: true

json.users @users do |user|
  json.extract! user, :id, :name, :points, :exact_bet_count, :league_rank
  if @extended
    json.team do
      json.name user.team&.name
      json.flag user.team&.flag
    end
    json.player do
      json.name user.player&.name
      json.flag user.player&.team&.flag
    end
  end
end

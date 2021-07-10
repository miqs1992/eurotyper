# frozen_string_literal: true

json.bets @bets do |bet|
  match = bet.match
  json.extract! bet, :id, :score1, :score2, :points, :exact, :bonus
  json.match do
    json.extract! match, :id, :score1, :score2
    json.time l(match.start_time, format: :short)
    json.round match.round.name
  end

  json.team1 do
    json.name match.team1.name
    json.flag match.team1.flag
  end

  json.team2 do
    json.name match.team2.name
    json.flag match.team2.flag
  end
end
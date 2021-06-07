# frozen_string_literal: true

json.match_day do
  json.extract! @match_day, :id, :day_number
  json.stop_bet_time l(@match_day.stop_bet_time, format: :short)
  json.round_name @match_day.round.name
  json.bonus_used @bonus_used

  json.bets @bets do |bet|
    json.extract! bet, :id, :score1, :score2, :points, :bonus
    json.finished bet.match.finished?

    json.team1 do
      json.name bet.match.team1.name
      json.flag bet.match.team1.flag
      json.score bet.match.score1
    end

    json.team2 do
      json.name bet.match.team2.name
      json.flag bet.match.team2.flag
      json.score bet.match.score2
    end
  end
end

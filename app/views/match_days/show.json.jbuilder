# frozen_string_literal: true

json.extract! @match_day, :id, :display_name, :stop_bet_time
json.users @users do |user|
  json.extract! user, :id, :name
end
json.matches @matches do |match|
  json.extract! match, :id, :score1, :score2, :team1_id, :team2_id
  json.team1 do
    json.name match.team1.name
    json.flag match.team1.flag
  end
  json.team2 do
    json.name match.team2.name
    json.flag match.team2.flag
  end
end
json.bets do
  @matches.each do |match|
    json.set! match.id do |match_json|
      match.bets.each do |bet|
        match_json.set! bet.user_id do |bet_json|
          bet_json.extract! bet, :score1, :score2, :bonus, :points
        end
      end
    end
  end
end

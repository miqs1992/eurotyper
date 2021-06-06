json.me do
  json.points @user.points
  json.main_league_place 3
  json.stop_bet_time @match_day.stop_bet_time.strftime("%-d %B %H:%M") if @match_day
end

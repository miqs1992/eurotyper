# frozen_string_literal: true

class MatchDaysController < ApplicationController
  def last
    @match_day = MatchDay.where(stop_bet_time: ..Time.current)
                         .order(stop_bet_time: :asc)
                         .last
    if @match_day
      assign_bets
      render "match_day", match_day: @match_day
    else
      head :ok
    end
  end

  def next
    @match_day = MatchDay.where(stop_bet_time: Time.current..)
                         .order(stop_bet_time: :asc)
                         .first
    if @match_day
      create_bets
      render "match_day", match_day: @match_day
    else
      head :ok
    end
  end

  private

  def assign_bets
    @bets = @match_day.bets
                      .includes(match: %i[team1 team2])
                      .where(user: current_user)
  end

  def create_bets
    @bets = @match_day.matches.includes(%i[team1 team2]).map do |match|
      match.bets.find_or_create_by(user: current_user)
    end
  end
end

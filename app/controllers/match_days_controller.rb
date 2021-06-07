# frozen_string_literal: true

class MatchDaysController < ApplicationController
  def last
    @match_day = MatchDay.previous
    if @match_day
      assign_bets
      render "match_day", match_day: @match_day
    else
      head :ok
    end
  end

  def next
    @match_day = MatchDay.next
    if @match_day
      @bonus_used = bonus_used(@match_day.round)
      create_bets
      render "match_day", match_day: @match_day
    else
      head :ok
    end
  end

  def update_bets
    @match_day = MatchDay.find(params[:id])
    assign_bets
    Bet.transaction do
      @bets.update_all(bonus: false) # rubocop:disable Rails/SkipsModelValidations
      @bets.each do |bet|
        bet.update!(bet_params(params[:bets][bet.id.to_s]))
      end
      head :ok
    rescue ActiveRecord::RecordInvalid
      head :unprocessable_entity
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

  def bet_params(my_params)
    my_params.permit(:score1, :score2, :bonus)
  end
end

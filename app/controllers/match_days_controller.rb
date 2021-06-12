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

  def show
    @match_day = MatchDay.find(params[:id])
    if @match_day.stop_bet_time.past?
      after_bet_time
    else
      before_bet_time
    end
  end

  private

  def before_bet_time
    respond_to do |format|
      format.html { render "before_bet_time" }
      format.json do
        @bonus_used = bonus_used(@match_day.round)
        create_bets
        render "match_day"
      end
    end
  end

  def after_bet_time
    respond_to do |format|
      format.html { render "after_bet_time" }
      format.json do
        @matches = @match_day.matches.includes(%i[team1 team2 bets])
        @users = User.all.order(:name)
        render 'show'
      end
    end
  end

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

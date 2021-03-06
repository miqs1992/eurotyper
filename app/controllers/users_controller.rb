# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        @extended = params[:extended] && MatchDay.previous.present?
        @users = User.all.order(league_rank: :asc)
        @users = @users.includes(:team, player: :team) if @extended
        @users = @users.limit(params[:per] || 20)
      end
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        @bets = @user.bets.includes(match: [:team1, :team2, match_day: :round])
        @bets = @bets.joins(:match).merge(Match.finished)
        @bets = @bets.order("matches.start_time" => :asc)
      end
    end
  end

  def me
    @user = current_user
    @match_day = MatchDay.next
  end
end

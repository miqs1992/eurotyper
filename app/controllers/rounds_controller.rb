# frozen_string_literal: true

class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    @matches = @round.matches.finished
  end

  def group
    @matches = Match.joins(match_day: :round).merge(Round.group_stage).finished
    respond_to do |format|
      format.html
      format.json { render "rounds/show" }
    end
  end

  def knockout
    @matches = Match.joins(match_day: :round).merge(Round.knockout_stage).finished
    respond_to do |format|
      format.html
      format.json { render "rounds/show" }
    end
  end
end

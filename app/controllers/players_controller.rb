# frozen_string_literal: true

class PlayersController < ApplicationController
  def index
    @players = Player.order(goals: :desc)
                     .includes(:team)
                     .limit(5)
  end
end

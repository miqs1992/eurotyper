# frozen_string_literal: true

class PlayersController < ApplicationController
  def index
    @players = Player.order(goals: :desc, assists: :desc)
                     .includes(:team)
                     .limit(5)
  end
end

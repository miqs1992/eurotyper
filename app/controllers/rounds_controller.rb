# frozen_string_literal: true

class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
  end
end

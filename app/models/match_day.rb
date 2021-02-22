# frozen_string_literal: true

class MatchDay < ApplicationRecord
  belongs_to :round

  validates :day_number, presence: true, uniqueness: true
  validates :stop_bet_time, presence: true
end

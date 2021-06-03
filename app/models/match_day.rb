# frozen_string_literal: true

class MatchDay < ApplicationRecord
  belongs_to :round
  has_many :matches, dependent: :destroy
  has_many :bets, through: :matches

  validates :day_number, presence: true, uniqueness: true
  validates :stop_bet_time, presence: true

  def calculate
    bets.each(&:calculate)
  end
end

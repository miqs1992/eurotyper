# frozen_string_literal: true

class MatchDay < ApplicationRecord
  belongs_to :round
  has_many :matches, dependent: :destroy
  has_many :bets, through: :matches

  validates :day_number, presence: true, uniqueness: true
  validates :stop_bet_time, presence: true

  def self.next
    where(stop_bet_time: Time.current..).order(stop_bet_time: :asc).first
  end

  def self.previous
    where(stop_bet_time: ..Time.current).order(stop_bet_time: :asc).last
  end

  def calculate
    bets.each(&:calculate)
  end

  def display_name
    "Match day #{day_number}"
  end
end

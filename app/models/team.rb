# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :flag, presence: true, uniqueness: true
  validate :one_winner, if: -> { winner? }

  has_many :players, dependent: :destroy

  def self.winner
    Team.find_by(winner: true)
  end

  private

  def one_winner
    return if Team.where.not(id: id).winner.blank?

    errors.add(:winner, "There can be only one winner")
  end
end

# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :team

  enum position: { goalkeeper: 0, defender: 1, midfielder: 2, forward: 3 }

  validate :one_king, if: -> { king? }

  def self.king
    Player.find_by(king: true)
  end

  private

  def one_king
    return if Player.where.not(id: id).king.blank?

    errors.add(:king, "There can be only one king")
  end
end

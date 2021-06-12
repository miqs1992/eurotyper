# frozen_string_literal: true

class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match

  delegate :match_day, to: :match
  delegate :round, to: :match_day

  validates :score1, numericality: { greater_than_or_equal_to: 0 }
  validates :score2, numericality: { greater_than_or_equal_to: 0 }
  validates :points, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: { scope: :match_id }
  validate :stop_bet_time, if: -> { new_record? || score1_changed? || score2_changed? }
  validate :bonus_used, if: -> { bonus_changed?(to: true ) }

  scope :with_bonus, -> { where(bonus: true ) }

  def calculate
    return unless match.finished?

    update(points: points_value)
  end

  def exact_bet?
    match.score1 == score1 && match.score2 == score2
  end

  def winner
    if score1 == score2
      :draw
    elsif score1 > score2
      :team1
    else
      :team2
    end
  end

  private

  def points_value
    value = if exact_bet?
              3
            elsif winner == match.winner
              1
            else
              0
            end
    value *= 2 if bonus?
    value
  end

  def stop_bet_time
    return if match.nil?

    errors.add(:base, "It is too late for changing") if match.match_day.stop_bet_time.past?
  end

  def bonus_used
    return unless Bet.where(match: round.matches).with_bonus.exists?(user_id: user_id)

    errors.add(:bonus, "Bonus already used!")
  end
end

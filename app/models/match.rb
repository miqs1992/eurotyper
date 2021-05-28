# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :match_day
  belongs_to :team1, class_name: "Team"
  belongs_to :team2, class_name: "Team"

  validates :start_time, presence: true
  validates :score1, numericality: { allow_nil: true }
  validates :score2, numericality: { allow_nil: true }
  validate :team1_and_team2_are_different

  delegate :round, to: :match_day

  private

  def team1_and_team2_are_different
    errors.add(:team1, "must be different than Team2") if team1_id == team2_id
  end
end

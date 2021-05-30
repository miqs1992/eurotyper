# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  belongs_to :player, optional: true
  belongs_to :team, optional: true
  has_many :bets, dependent: :delete_all
  validates :name, presence: true
  validate :stop_bet_time, if: -> { team_id_changed? || player_id_changed? }

  def calculate
    update(points: bets.sum(:points))
  end

  private

  def stop_bet_time
    return unless MatchDay.where("stop_bet_time < ?", Time.current).any?

    errors.add(:base, "Can edit top scorer or winning team")
  end
end

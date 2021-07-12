# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable

  belongs_to :player, optional: true
  belongs_to :team, optional: true
  has_many :bets, dependent: :delete_all
  validates :name, presence: true
  validate :stop_bet_time, if: -> { team_id_changed? || player_id_changed? }

  def self.calculate
    king_id = Player.king&.id
    winner_id = Team.winner&.id
    unscoped.all.find_each { |user| user.calculate(winner_id, king_id) }
    rank = 1
    unscoped.all.order(points: :desc, exact_bet_count: :desc).each do |user|
      user.update(league_rank: rank)
      rank += 1
    end
    true
  end

  def calculate(winner_id = nil, king_id = nil)
    new_points = bets.sum(:points)
    new_points += 7 if team_id && team_id == winner_id
    new_points += 5 if player_id && player_id == king_id
    update(
      points: new_points,
      exact_bet_count: bets.exact.count
    )
  end

  private

  def stop_bet_time
    return unless MatchDay.where("stop_bet_time < ?", Time.current).any?

    errors.add(:base, "Can edit top scorer or winning team")
  end
end

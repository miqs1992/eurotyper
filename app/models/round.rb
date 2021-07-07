# frozen_string_literal: true

class Round < ApplicationRecord
  has_many :match_days, dependent: :destroy
  has_many :matches, through: :match_days

  enum stage: { group: 0, knockout: 1 }, _suffix: true
  validates :name, presence: true, uniqueness: true
end

# frozen_string_literal: true

class Round < ApplicationRecord
  has_many :match_days, dependent: :destroy
end

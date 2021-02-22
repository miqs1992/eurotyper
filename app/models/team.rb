# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :flag, presence: true, uniqueness: true
end

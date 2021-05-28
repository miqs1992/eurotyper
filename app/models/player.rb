# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :team

  enum position: { goalkeeper: 0, defender: 1, midfielder: 2, forward: 3 }
end

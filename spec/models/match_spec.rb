# frozen_string_literal: true

require "rails_helper"

RSpec.describe Match, type: :model do
  it "has valid factory" do
    expect(FactoryBot.create(:match)).to be_valid
  end

  context "instance methods" do
    context "#winner" do
      it "returns proper winner" do
        match = FactoryBot.build(:match, score1: 2, score2: 2)
        expect(match.winner).to equal(:draw)
        match.score1 = 3
        expect(match.winner).to equal(:team1)
        match.score1 = 0
        expect(match.winner).to equal(:team2)
      end
    end
  end
end

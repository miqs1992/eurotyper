# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bet, type: :model do
  context "validations" do
    it "has valid factory" do
      expect(FactoryBot.create(:bet)).to be_valid
    end

    it "is invalid if the same pair of user and match" do
      bet = FactoryBot.create(:bet)
      new_bet = Bet.new(
        user: bet.user,
        match: bet.match,
        score1: 0,
        score2: 2
      )
      expect(new_bet).not_to be_valid
    end

    context "#stop_bet_time" do
      it "is invalid when updating after stop bet time" do
        bet = FactoryBot.create(:bet, score1: 0)
        travel_to bet.match_day.stop_bet_time.advance(hours: 1) do
          bet.score1 = 5
          expect(bet).not_to be_valid
        end
      end

      it "is invalid when creating after stop bet time" do
        match = FactoryBot.create(:match)
        travel_to match.match_day.stop_bet_time.advance(minutes: 1) do
          bet = FactoryBot.build(:bet, match: match)
          expect(bet).not_to be_valid
        end
      end
    end
  end

  context "instance methods" do
    context "#winner" do
      it "returns proper winner" do
        bet = FactoryBot.build(:bet, score1: 2, score2: 2)
        expect(bet.winner).to equal(:draw)
        bet.score1 = 3
        expect(bet.winner).to equal(:team1)
        bet.score1 = 0
        expect(bet.winner).to equal(:team2)
      end
    end

    context "#calculate" do
      let(:match) { FactoryBot.create(:match, score1: 2, score2: 2) }
      let(:bet) { FactoryBot.create(:bet, match_id: match.id, score1: 2, score2: 2) }

      it "doesn't update when match is not finished" do
        expect { bet.calculate }.not_to(change { bet.points })
      end

      it "sets 3 point for exact bet" do
        match.update!(finished: true)
        expect { bet.calculate }.to change { bet.points }.to(3)
      end

      it "sets 6 point for exact bet with bonus" do
        match.update!(finished: true)
        bet.update!(bonus: true)
        expect { bet.calculate }.to change { bet.points }.to(6)
      end

      it "sets 3 point for partially correct bet" do
        match.update!(finished: true, score1: 1, score2: 1)
        expect { bet.calculate }.to change { bet.points }.to(1)
      end

      it "doesn't update for wrong bet" do
        match.update!(finished: true, score1: 2, score2: 1)
        expect { bet.calculate }.not_to(change { bet.points })
      end
    end
  end
end

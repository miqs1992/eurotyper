# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  it "has valid factory" do
    expect(FactoryBot.create(:user)).to be_valid
  end

  context "validations" do
    let(:user) { FactoryBot.create(:user) }
    let(:player) { FactoryBot.create(:player) }
    let(:team) { FactoryBot.create(:team) }

    it "can change player and team before first match day" do
      FactoryBot.create(:match_day, stop_bet_time: 1.day.from_now)
      user.team = team
      user.player = player
      expect(user).to be_valid
    end

    it "can't change player and team after first match day" do
      FactoryBot.create(:match_day, stop_bet_time: 1.day.ago)
      user.team = team
      user.player = player
      expect(user).not_to be_valid
    end

    it "can't change player and team in the  middle" do
      FactoryBot.create(:match_day, stop_bet_time: 1.day.from_now)
      FactoryBot.create(:match_day, stop_bet_time: 1.day.ago)
      user.team = team
      user.player = player
      expect(user).not_to be_valid
    end
  end
end

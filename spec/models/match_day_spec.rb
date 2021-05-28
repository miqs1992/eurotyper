# frozen_string_literal: true

require "rails_helper"

RSpec.describe MatchDay do
  it "has valid factory" do
    expect(FactoryBot.create(:match_day)).to be_valid
  end
end

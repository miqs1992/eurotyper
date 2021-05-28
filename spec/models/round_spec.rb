# frozen_string_literal: true

require "rails_helper"

RSpec.describe Round do
  it "has valid factory" do
    expect(FactoryBot.create(:round)).to be_valid
  end
end

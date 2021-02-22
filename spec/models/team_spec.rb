# frozen_string_literal: true

require "rails_helper"

RSpec.describe Team do
  it "has valid factory" do
    expect(FactoryBot.build(:team)).to be_valid
  end
end

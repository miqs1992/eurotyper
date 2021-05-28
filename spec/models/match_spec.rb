# frozen_string_literal: true

require "rails_helper"

RSpec.describe Match, type: :model do
  it "has valid factory" do
    expect(FactoryBot.create(:match)).to be_valid
  end
end

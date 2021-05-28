# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin panel", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
  end

  it "allows admin to visit admin panel" do
    login_as @admin
    visit admin_root_path
    expect(page).to have_text("Admin")
  end

  it "raises 404 for normal user" do
    login_as FactoryBot.create(:user)
    visit admin_root_path
    expect(page).to have_text("Not Found")
  end
end

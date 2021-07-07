# frozen_string_literal: true

namespace :bets do
  desc "Sets exact flag"
  task set_exact: :environment do
    bets = Bet.where("points >= ?", 3)
    bets.update_all(exact: true) # rubocop:disable Rails/SkipsModelValidations
  end
end

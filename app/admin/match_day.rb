# frozen_string_literal: true

ActiveAdmin.register MatchDay do
  menu parent: "Matches"
  permit_params :stop_bet_time, :day_number, :round_id
end

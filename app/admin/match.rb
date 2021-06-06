# frozen_string_literal: true

ActiveAdmin.register Match do
  menu parent: 'Matches'
  permit_params :match_day_id, :team1_id, :team2_id, :start_time,
                :score1, :score2, :finished
end

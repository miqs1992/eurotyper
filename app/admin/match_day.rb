# frozen_string_literal: true

ActiveAdmin.register MatchDay do
  menu parent: "Matches"
  permit_params :stop_bet_time, :day_number, :round_id

  action_item :calculate, only: :show do
    link_to "Calculate match day", calculate_admin_match_day_path, method: :post
  end

  member_action :calculate, title: "Calculate match day", method: :post do
    unless resource.matches.finished.count == resource.matches.count
      return redirect_to admin_match_day_path(resource), alert: "Set all matches to finished first!"
    end

    resource.calculate
    redirect_to admin_match_day_path(resource),
                notice: "Match day calculated! Now recalculate users!"
  end

  show do
    attributes_table do
      row :id
      row :round
      row :stop_bet_time
      row(:bets_count) { resource.bets.count }
    end

    panel "Matches" do
      table_for resource.matches.includes(:team1, :team2) do
        column :id
        column :team1
        column :team2
        column :score1
        column :score2
        column :finished
        column(:edit) { |i| link_to("Edit", edit_admin_match_path(i)) }
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :round
      f.input :day_number
      f.input :stop_bet_time, as: :datetime_picker
    end
    f.actions
  end
end

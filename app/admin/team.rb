# frozen_string_literal: true

ActiveAdmin.register Team do
  permit_params :name, :flag

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :flag do |team|
            "<span class='flag-icon flag-icon-#{team.flag}'></span>".html_safe # rubocop:disable Rails/OutputSafety
          end
        end
      end
      column do
        panel "Players" do
          table_for team.players.order(goals: :desc) do
            column(:name) { |c| auto_link(c) }
            column :position
            column :goals
          end
        end
      end
    end
  end
end

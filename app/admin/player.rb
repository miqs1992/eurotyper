# frozen_string_literal: true

ActiveAdmin.register Player do
  menu parent: "Teams"
  permit_params :name, :position, :goals, :assists, :team_id, :king

  controller do
    def update
      update! do |format|
        format.html { redirect_to admin_players_path } if resource.valid?
      end
    end
  end
end

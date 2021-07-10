# frozen_string_literal: true

ActiveAdmin.register Player do
  menu parent: "Teams"
  permit_params :name, :position, :goals, :assists, :team_id, :king
end

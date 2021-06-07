# frozen_string_literal: true

ActiveAdmin.register Player do
  menu parent: "Teams"
  permit_params :name, :position, :goals, :team_id
end

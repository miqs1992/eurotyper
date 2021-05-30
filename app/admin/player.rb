# frozen_string_literal: true

ActiveAdmin.register Player do
  permit_params :name, :position, :goals, :team_id
end

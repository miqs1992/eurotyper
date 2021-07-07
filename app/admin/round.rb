# frozen_string_literal: true

ActiveAdmin.register Round do
  menu parent: "Matches"
  permit_params :name, :score_factor, :stage
end

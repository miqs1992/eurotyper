# frozen_string_literal: true

ActiveAdmin.register Round do
  permit_params :name, :score_factor
end

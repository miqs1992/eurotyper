# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :name, :email, :password

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
    end
    f.actions
  end

  index do
    id_column
    column :name
    column :email
    column :player, label: "Top scorer"
    column :team, label: "Winner"
    column :points
    actions
  end
end

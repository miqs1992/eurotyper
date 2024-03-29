# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :name, :email, :paid

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :email
      f.input :name
      f.input :paid
    end
    f.actions
  end

  index do
    id_column
    column :name
    column :email
    column :points
    column :exact_bet_count
    column :paid
    column :league_rank
    column :sign_in_count
    actions
  end

  action_item :calculate, only: :index do
    link_to "Re-calculate users", calculate_admin_users_path, method: :post
  end

  collection_action :calculate, title: "Re-calculate users", method: :post do
    User.calculate
    redirect_to admin_users_path, notice: "Users recalculated!"
  end

  controller do
    def create
      User.invite!(permitted_params[:user], current_user)

      redirect_to admin_users_path
    end
  end
end

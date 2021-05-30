# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_active_admin_user!
    authenticate_user!
    raise ActionController::RoutingError, "Not Found" unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[password password_confirmation current_password
                                name team_id player_id]
    )
  end
end

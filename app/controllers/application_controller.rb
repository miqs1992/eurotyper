# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authenticate_active_admin_user!
    authenticate_user!
    raise ActionController::RoutingError, "Not Found" unless current_user.admin?
  end
end

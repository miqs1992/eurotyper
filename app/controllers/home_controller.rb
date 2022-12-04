# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :health

  def index; end

  def health
    respond_to do |format|
      format.html { render plain: "OK" }
      format.json { render json: { status: "OK" } }
    end
  end
end

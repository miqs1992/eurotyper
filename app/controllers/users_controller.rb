# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def me
    @user = current_user
    @match_day = MatchDay.next
  end
end

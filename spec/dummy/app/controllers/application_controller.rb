# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index
    redirect_to "/hotsheet"
  end

  protected

  def current_user
    @current_user ||= User.first
  end
end

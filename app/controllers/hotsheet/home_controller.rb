# frozen_string_literal: true

class Hotsheet::HomeController < Hotsheet::ApplicationController
  def show; end

  def error
    render "error", status: :not_found
  end
end

# frozen_string_literal: true

class Hotsheet::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # :nocov:
  ENV["HOTSHEET_BASIC_AUTH"]&.split(":")&.then do |name, password|
    http_basic_authenticate_with name:, password:
  end
  # :nocov:
end

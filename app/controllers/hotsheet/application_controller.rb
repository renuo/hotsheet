# frozen_string_literal: true

module Hotsheet
  class ApplicationController < ActionController::Base
    include Pagy::Backend
  end
end

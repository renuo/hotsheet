# frozen_string_literal: true

module Hotsheet
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:models) { {} }
  end
end

# frozen_string_literal: true

module RailsDbManager
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:excluded_models) { nil }
  end
end

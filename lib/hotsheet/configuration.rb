# frozen_string_literal: true

module Hotsheet
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:models) { {} }

    def initialize
      self.models = {}
    end

    def model(name, &block)
      model_config = ModelConfig.new
      yield model_config if block
      models[name.to_s] = model_config
    end

    class ModelConfig
      attr_accessor :included_attributes, :excluded_attributes
    end
  end
end

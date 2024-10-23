# frozen_string_literal: true

module Hotsheet
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:models) { {} }

    def model(name, &)
      model_config = ModelConfig.new
      yield model_config
      models[name.to_s] = model_config
    end

    class ModelConfig
      attr_accessor :included_attributes, :excluded_attributes
    end
  end
end

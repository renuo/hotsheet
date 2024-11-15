# frozen_string_literal: true

module Hotsheet
  class << self
    def editable_attributes_for(model:)
      @editable_attributes_for ||= {}
      @editable_attributes_for[model] ||= fetch_editable_attributes(model)
    end

    private

    def fetch_editable_attributes(model)
      model_config = Hotsheet.configuration.models[model.to_s]

      if model_config&.included_attributes
        model_config.included_attributes.map(&:to_s)
      elsif model_config&.excluded_attributes
        model.column_names - model_config.excluded_attributes.map(&:to_s)
      else
        model.column_names
      end
    end
  end
end

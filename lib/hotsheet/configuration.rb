# frozen_string_literal: true

module Hotsheet
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:models) { {} }

    def initialize
      self.models = {}
    end

    def model(name)
      model_config = ModelConfig.new(name).tap do |config|
        yield(config) if block_given?
        Rails.application.config.to_prepare { config.validate! }
      end
      models[name.to_s] = model_config
    end

    class ModelConfig
      attr_accessor :included_attributes, :excluded_attributes, :model_name

      def initialize(model_name)
        @model_name = model_name
        @included_attributes = []
        @excluded_attributes = []
      end

      def validate!
        return unless ActiveRecord::Base.connection.table_exists?(model_class.table_name)

        ensure_only_one_attribute_set
        validate_attribute_existence
      end

      private

      def ensure_only_one_attribute_set
        return unless included_attributes.any? && excluded_attributes.any?

        raise "Can only specify either included or excluded attributes for '#{model_name}'"
      end

      def validate_attribute_existence
        all_attributes = model_class.column_names

        (included_attributes + excluded_attributes).each do |attr|
          unless all_attributes.include?(attr.to_s)
            raise "Attribute '#{attr}' doesn't exist on model '#{model_name}'"
          end
        end
      end

      def model_class
        model_name.to_s.constantize
      end
    end
  end
end

# frozen_string_literal: true

Rails.application.config.to_prepare do # rubocop:disable Metrics/BlockLength
  # Only run this initializer when running the Rails server
  next unless Rails.env.test? || defined? Rails::Server

  Hotsheet.configuration.models.each_key do |model| # rubocop:disable Metrics/BlockLength
    model.constantize.class_eval do
      class << self
        def editable_attributes
          @editable_attributes ||= fetch_editable_attributes
        end

        private

        def fetch_editable_attributes
          config = Hotsheet.configuration.models[name]
          excluded_attributes = config.excluded_attributes

          if config.included_attributes.present?
            raise "Can only specify either included or excluded attributes" if excluded_attributes.present?

            attrs_to_s(config.included_attributes)
          elsif excluded_attributes.present?
            column_names - attrs_to_s(excluded_attributes)
          else
            column_names
          end
        end

        def attrs_to_s(attrs)
          attrs.map do |attr|
            raise "Attribute '#{attr}' doesn't exist on model '#{name}'" if column_names.exclude? attr.to_s

            attr.to_s
          end
        end
      end
    end

    model.constantize.editable_attributes
  end
end

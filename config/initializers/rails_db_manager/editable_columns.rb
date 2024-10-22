# frozen_string_literal: true

Rails.application.config.after_initialize do # rubocop:disable Metrics/BlockLength
  RailsDbManager.configuration.models.each_key do |model| # rubocop:disable Metrics/BlockLength
    model = model.to_s.constantize

    model.class_eval do
      class << self
        def editable_columns
          @editable_columns ||= fetch_editable_columns
        end

        private

        def fetch_editable_columns
          config = RailsDbManager.configuration.models[name.to_sym]

          if config.key?(:included_attributes)
            raise "Can only specify either included or excluded attributes" if config.key?(:excluded_attributes)

            attrs_to_s(config[:included_attributes])
          elsif config.key?(:excluded_attributes)
            column_names - attrs_to_s(config[:excluded_attributes])
          else
            column_names
          end
        end

        def attrs_to_s(attrs)
          attrs.map do |attr|
            column_names.include?(attr.to_s) ? attr.to_s : raise("Attribute '#{attr}' doesn't exist on model '#{name}'")
          end
        end
      end
    end

    model.editable_columns
  end
end

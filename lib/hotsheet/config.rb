# frozen_string_literal: true

module Hotsheet::Config
  def merge_config!(default, custom)
    config = default.transform_values { |value| value[:default] }

    custom.each do |key, value|
      unless default.key? key
        raise Hotsheet::Error, "Config must be one of #{default.keys}, got '#{key}'"
      end

      ensure_allowed_value! key, value, default[key]
      config[key] = value
    end

    config
  end

  private

  def ensure_allowed_value!(key, value, config)
    allowed = config[:allowed_classes]
    value = value.class

    return if allowed.include? value

    raise Hotsheet::Error, "Config '#{key}' must be one of #{allowed}, got '#{value}'"
  end
end

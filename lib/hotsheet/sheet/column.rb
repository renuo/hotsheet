# frozen_string_literal: true

class Hotsheet::Sheet::Column
  attr_accessor :name

  DEFAULT_CONFIG = { editable: true, visible: true }.freeze

  def initialize(name, config)
    @name = name.to_s
    @config = DEFAULT_CONFIG.merge config

    validate_config! config
  end

  def visible?
    @config[:visible]
  end

  def editable?
    @config[:editable]
  end

  private

  def validate_config!(config)
    config.each do |key, value|
      ensure_config_exists! key
      validate_config_value! key, value
    end
  end

  def ensure_config_exists!(key)
    return if DEFAULT_CONFIG.key? key

    raise Hotsheet::Error, "Unknown config '#{key}' for column '#{@name}'"
  end

  def validate_config_value!(key, value)
    return if [true, false].include? value

    raise Hotsheet::Error, "Invalid config '#{key}' for column '#{@name}'"
  end
end

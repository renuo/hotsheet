# frozen_string_literal: true

class Hotsheet::Sheet::Column
  attr_accessor :name

  DEFAULT_CONFIG = { editable: true, visible: true }.freeze

  def initialize(model, name, config)
    @model = model
    @name = name.to_s
    @config = DEFAULT_CONFIG.merge config
  end

  def human_name
    @model.human_attribute_name @name
  end

  def visible?
    @config[:visible]
  end

  def editable?
    @config[:editable]
  end

  def update!(id, value)
    raise Hotsheet::Error, "Forbidden" unless editable?

    model = @model.find_by(id:)
    raise Hotsheet::Error, "Not found" if model.nil?
    raise Hotsheet::Error, model.errors.full_messages.first unless model.update @name => value
  end

  def validate!
    ensure_database_column_exists!

    @config.each do |key, value|
      ensure_config_exists! key
      validate_config_value! key, value
    end
  end

  private

  def ensure_database_column_exists!
    return if @model.column_names.include? @name.to_s

    raise Hotsheet::Error, "Unknown database column '#{@name}' for '#{@model.table_name}'"
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

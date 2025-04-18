# frozen_string_literal: true

class Hotsheet::Sheet
  DEFAULT_CONFIG = { editable: true, visible: true }.freeze

  attr_accessor :model

  def initialize(model_name)
    error "Unknown model '#{model_name}'" unless Object.const_defined? model_name

    @model = model_name.to_s.constantize
    @rows = []
  end

  def row(name, **config)
    @config = config

    validate_column_name! name
    validate_config! name

    @rows << @config.merge(name: name.to_sym)
  end

  def rows
    @rows.filter_map do |row|
      next unless row[:visible]

      row.merge label: @model.human_attribute_name(row[:name]), editable: row[:editable]
    end
  end

  def human_name
    @model.model_name.human count: 2
  end

  def update!(id:, attr:, value:)
    row = @rows.find { |r| r[:name] == attr }
    error "Forbidden" unless row && row[:visible] && row[:editable]

    @model.find(id).update! attr => value
  rescue StandardError => e
    error e.message
  end

  private

  def validate_column_name!(name)
    return if @model.column_names.include? name.to_s

    error "Unknown database column '#{name}' for '#{@model.table_name}'"
  end

  def validate_config!(name)
    @config.each do |key, value|
      error "Unknown config '#{key}' for row '#{name}'" unless DEFAULT_CONFIG.key? key
      error "Invalid config '#{key}' for row '#{name}'" unless value == false
    end
    @config = DEFAULT_CONFIG.merge @config
  end

  def error(message)
    raise Hotsheet::Error, message
  end
end

# frozen_string_literal: true

class Hotsheet::Sheet
  DEFAULT_CONFIG = { editable: true, visible: true }.freeze

  attr_accessor :model

  def initialize(model_name)
    error "Unknown model '#{model_name}'" unless Object.const_defined? model_name

    @model = model_name.to_s.constantize
    @columns = []
  end

  def row(name, **config)
    @config = config

    validate_column_name! name
    validate_config!

    @columns << @config.merge(name: name.to_sym)
  end

  def columns_for(current_user)
    @current_user = current_user
    @columns.filter_map do |column|
      next unless allowed? column[:visible]

      column.merge label: @model.human_attribute_name(column[:name]),
                   editable: allowed?(column[:editable])
    end
  end

  def human_name
    @model.model_name.human count: 2
  end

  private

  def allowed?(config)
    config.is_a?(Proc) ? config.call(@current_user) : config
  end

  def validate_column_name!(name)
    return if @model.column_names.include? name.to_s

    error "Unknown column '#{@model.table_name}.#{name}'"
  end

  def validate_config!
    @config.each do |key, value|
      error "Unknown config '#{key}'" unless DEFAULT_CONFIG.key? key
      error "Invalid config '#{key}'" unless value == false || value.is_a?(Proc)
    end
    @config = DEFAULT_CONFIG.merge @config
  end

  def error(message)
    raise Hotsheet::Error, message
  end
end

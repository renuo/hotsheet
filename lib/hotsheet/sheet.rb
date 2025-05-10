# frozen_string_literal: true

class Hotsheet::Sheet
  attr_accessor :model

  def initialize(name, config = {})
    ensure_model_exists! name

    @config = config
    @model = name.to_s.constantize
    @columns = []
  end

  def human_name
    @model.model_name.human count: 2
  end

  def column(name, config = {})
    ensure_column_exists! name

    @columns << Column.new(name, config)
  end

  def columns
    @columns.select(&:visible?)
  end

  def use_default_configuration
    @model.column_names.each { |name| column name }
  end

  private

  def ensure_model_exists!(name)
    return if Object.const_defined? name

    raise Hotsheet::Error, "Unknown model '#{name}'"
  end

  def ensure_column_exists!(name)
    return if @model.column_names.include? name.to_s

    raise Hotsheet::Error, "Unknown column '#{name}' for '#{@model.table_name}'"
  end
end

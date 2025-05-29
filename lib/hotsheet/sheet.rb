# frozen_string_literal: true

class Hotsheet::Sheet
  include Hotsheet::Config

  CONFIG = {}.freeze

  attr_reader :config, :model

  def initialize(name, config, &columns)
    @config = merge_config! CONFIG, config
    @model = name.to_s.constantize
    @columns = {}

    column :id, editable: false
    columns ? instance_eval(&columns) : use_default_configuration
  end

  def columns
    @columns.select { |_name, column| column.visible? }
  end

  def cells_for(columns)
    @model.pluck(*columns.keys).transpose
  end

  private

  def use_default_configuration
    @model.column_names[1..].each { |name| column name }
  end

  def column(name, config = {})
    ensure_column_exists! name

    @columns[name.to_s] = Hotsheet::Column.new config
  end

  def ensure_column_exists!(name)
    return if @model.column_names.include? name.to_s

    raise Hotsheet::Error, "Column must be one of #{@model.column_names}, got '#{name}'"
  end
end

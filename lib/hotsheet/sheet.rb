# frozen_string_literal: true

class Hotsheet::Sheet
  include Hotsheet::Config

  attr_reader :config, :model

  CONFIG = {
    per: { allowed_classes: [Integer], default: 100 },
    as: { allowed_classes: [String, Symbol], default: nil },
    scope: { allowed_classes: [Proc], default: nil }
  }.freeze

  def initialize(name, config = {}, &columns)
    @config = merge_config! CONFIG, config
    @model = name.to_s.constantize
    @columns = {}

    column :id, editable: false
    columns ? instance_eval(&columns) : use_default_configuration
  end

  def name
    (@config[:as] || @model.table_name).to_s
  end

  def label
    return @model.model_name.human(count: 2) unless @config[:as]

    @config[:as].to_s.humanize
  end

  def scoped
    @config[:scope] ? @model.instance_exec(&@config[:scope]) : @model
  end

  def columns
    @columns.select { |_name, column| column.visible? }
  end

  def cells_for(columns, params)
    page = page_info params[:page]

    [scoped.order(:id).limit(page[:limit]).offset(page[:offset]).pluck(*columns.keys).transpose, page]
  end

  private

  def page_info(page)
    total = scoped.count
    page = (page || 1).to_i
    limit = @config[:per]
    offset = (1..total.fdiv(limit).ceil).cover?(page) ? page.pred * limit : 0

    { count: page * limit, total:, next: page.next, limit:, offset: }
  end

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

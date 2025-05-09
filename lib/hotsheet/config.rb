# frozen_string_literal: true

class Hotsheet::Config
  attr_reader :sheets

  def initialize
    @sheets = {}
  end

  def sheet(name, config = {}, &columns)
    sheet = Hotsheet::Sheet.new(name, config).tap do |s|
      columns ? s.instance_eval(&columns) : s.use_default_configuration
    end

    @sheets[sheet.model.table_name] = sheet
  end
end

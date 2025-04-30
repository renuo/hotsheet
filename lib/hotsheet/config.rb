# frozen_string_literal: true

class Hotsheet::Config
  attr_reader :sheets

  def initialize
    @sheets = {}
  end

  def sheet(name, config = {}, &rows)
    sheet = Hotsheet::Sheet.new(name, config).tap do |s|
      rows ? s.instance_eval(&rows) : s.use_default_configuration
    end

    @sheets[sheet.model.table_name] = sheet
  end
end

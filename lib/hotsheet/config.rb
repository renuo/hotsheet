# frozen_string_literal: true

class Hotsheet::Config
  attr_reader :sheets

  def initialize
    @sheets = {}
  end

  def sheet(model_name, &config)
    sheet = Hotsheet::Sheet.new(model_name).tap do |s|
      if config
        s.instance_eval(&config)
      else
        s.model.column_names.each { |column_name| s.row column_name }
      end
    end

    @sheets[sheet.model.table_name] = sheet
  end
end

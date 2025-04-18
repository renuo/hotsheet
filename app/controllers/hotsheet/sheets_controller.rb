# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet

  def index
    @rows = @sheet.rows
    @cells = @sheet.model.pluck @rows.pluck(:name)
    @cells = @rows.length == 1 ? [@cells] : @cells.transpose
  end

  private

  def set_sheet
    @sheet = Hotsheet.sheets[params[:sheet_name]]
  end
end

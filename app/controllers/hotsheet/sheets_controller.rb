# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet

  def index
    @columns = @sheet.columns_for defined?(current_user) && current_user
    @cells = @sheet.model.pluck @columns.pluck(:name)
    @cells = @columns.length == 1 ? [@cells] : @cells.transpose
  end

  private

  def set_sheet
    @sheet = Hotsheet.sheets[params[:sheet_name]]
  end
end

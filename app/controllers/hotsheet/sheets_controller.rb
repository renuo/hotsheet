# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet
  before_action :set_column, only: :update

  def index
    @columns = @sheet.columns
    @cells = @sheet.model.pluck(*@columns.map(&:name))
    @cells = @columns.length == 1 ? [@cells] : @cells.transpose
  end

  def update
    @column&.update! params[:id], params[:to]
    json = {}
  rescue Hotsheet::Error => e
    json = { error: e.message, value: params[:from], x: params[:x], y: params[:y] }
  ensure
    respond_to { |format| format.any { render json: } }
  end

  def error
    render "error", status: :not_found
  end

  private

  def set_sheet
    @sheet = Hotsheet.sheets[params[:sheet_name]]
  end

  def set_column
    @column = @sheet.columns.find { |column| column.name == params[:column_name] }
  end
end

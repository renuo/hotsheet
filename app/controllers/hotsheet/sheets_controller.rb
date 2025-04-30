# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet
  before_action :set_row, only: :update

  def index
    @rows = @sheet.rows
    @cells = @sheet.model.pluck(*@rows.map(&:name))
    @cells = @rows.length == 1 ? [@cells] : @cells.transpose
  end

  def update
    @row&.update! params[:id], params[:to]
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

  def set_row
    @row = @sheet.rows.find { |row| row.name == params[:row_name] }
  end
end
